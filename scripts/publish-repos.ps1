param(
    [Parameter(Mandatory = $false)]
    [string]$Prefix = "bits-group",

    [Parameter(Mandatory = $false)]
    [ValidateSet("public", "private")]
    [string]$Visibility = "public"
)

$ErrorActionPreference = "Stop"

function Assert-Command($name) {
    if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
        throw "Required command '$name' was not found in PATH."
    }
}

Assert-Command "git"
Assert-Command "gh"

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$services = @(
    @{ Name = "student-service"; Path = "src/StudentService" },
    @{ Name = "course-service"; Path = "src/CourseService" },
    @{ Name = "enrollment-service"; Path = "src/EnrollmentService" },
    @{ Name = "api-gateway"; Path = "src/ApiGateway" }
)

$orchestrationRepoName = "$Prefix-microservices-deployment"
$orchestrationPath = $root

function Init-And-Push-Repo($repoName, $path, $readmeText) {
    Write-Host "\n--- Processing $repoName ($path) ---"
    Push-Location $path

    if (-not (Test-Path ".git")) {
        git init
        git branch -M main
    }

    if (-not (Test-Path ".gitignore")) {
@"
bin/
obj/
.vs/
.vscode/
"@ | Set-Content -Path ".gitignore"
    }

    if (-not (Test-Path "README.md")) {
        $readmeText | Set-Content -Path "README.md"
    }

    git add .

    $hasChanges = (git status --porcelain)
    if ($hasChanges) {
        git commit -m "Initial microservice setup"
    }

    $fullRepo = "bijesh-bits/$repoName"

    $repoExists = $false
    try {
        gh repo view $fullRepo | Out-Null
        $repoExists = $true
    } catch {
        $repoExists = $false
    }

    if (-not $repoExists) {
        gh repo create $fullRepo --$Visibility --source . --remote origin --push
    } else {
        if (-not (git remote | Select-String -SimpleMatch "origin")) {
            git remote add origin "https://github.com/$fullRepo.git"
        }
        git push -u origin main
    }

    Pop-Location
}

foreach ($service in $services) {
    $repoName = "$Prefix-$($service.Name)"
    $servicePath = Join-Path $root $service.Path
    $readme = "# $repoName`n`nGenerated from assignment workspace."
    Init-And-Push-Repo -repoName $repoName -path $servicePath -readmeText $readme
}

Write-Host "\n--- Processing orchestration repo ($orchestrationRepoName) ---"
Push-Location $orchestrationPath

if (-not (Test-Path ".git")) {
    git init
    git branch -M main
}

if (-not (Test-Path ".gitignore")) {
@"
**/bin/
**/obj/
.vs/
.vscode/
"@ | Set-Content -Path ".gitignore"
}

git add .
$hasRootChanges = (git status --porcelain)
if ($hasRootChanges) {
    git commit -m "Initial deployment and docs setup"
}

$rootFullRepo = "bijesh-bits/$orchestrationRepoName"
$rootRepoExists = $false
try {
    gh repo view $rootFullRepo | Out-Null
    $rootRepoExists = $true
} catch {
    $rootRepoExists = $false
}

if (-not $rootRepoExists) {
    gh repo create $rootFullRepo --$Visibility --source . --remote origin --push
} else {
    if (-not (git remote | Select-String -SimpleMatch "origin")) {
        git remote add origin "https://github.com/$rootFullRepo.git"
    }
    git push -u origin main
}

Pop-Location

Write-Host "\nAll repositories processed successfully."
