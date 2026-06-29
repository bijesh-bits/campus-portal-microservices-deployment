param(
    [Parameter(Mandatory = $false)]
    [string]$Prefix = "campus-portal"
)

$ErrorActionPreference = "Stop"

Write-Host "Setting up PATH with git and GitHub CLI..."
$gitPath = "C:\Users\z0049jnv\AppData\Local\Programs\Git\cmd"
$ghPath = "C:\Program Files\GitHub CLI"

$env:PATH = "$ghPath;$gitPath;" + $env:PATH

Write-Host "Verifying tools..."
& git --version
& gh --version
& gh auth status

Write-Host "`nProceeding with repository publishing using prefix: $Prefix`n"

Set-Location 'D:\__Projects\BITS Pilani\Scalable_Project'

$root = Get-Location
$services = @(
    @{ Name = "student-service"; Path = "src/StudentService" },
    @{ Name = "course-service"; Path = "src/CourseService" },
    @{ Name = "enrollment-service"; Path = "src/EnrollmentService" },
    @{ Name = "api-gateway"; Path = "src/ApiGateway" }
)

function Init-And-Push-Repo($repoName, $path) {
    Write-Host "=== Processing $repoName ($path) ===" -ForegroundColor Cyan
    
    $fullPath = Join-Path $root $path
    if (-not (Test-Path $fullPath)) {
        Write-Host "Path does not exist: $fullPath" -ForegroundColor Red
        return
    }
    
    Push-Location $fullPath

    if (-not (Test-Path ".git")) {
        & git init
        & git branch -M main
    }

    if (-not (Test-Path ".gitignore")) {
        @"
bin/
obj/
.vs/
.vscode/
*.user
"@ | Set-Content -Path ".gitignore"
    }

    if (-not (Test-Path "README.md")) {
        $readme = "# $repoName`n`nMicroservice from campus-portal student enrollment system."
        $readme | Set-Content -Path "README.md"
    }

    & git add .

    $status = & git status --porcelain
    if ($status) {
        & git commit -m "Initial setup: $repoName"
    }

    $fullRepo = "bijesh-bits/$repoName"

    $repoExists = $false
    try {
        & gh repo view $fullRepo 2>&1 | Out-Null
        $repoExists = $true
        Write-Host "Repository already exists: $fullRepo" -ForegroundColor Yellow
    } catch {
        $repoExists = $false
    }

    if (-not $repoExists) {
        Write-Host "Creating new repository: $fullRepo" -ForegroundColor Green
        & gh repo create $fullRepo --public --source . --remote origin --push
    } else {
        Write-Host "Pushing to existing repository: $fullRepo" -ForegroundColor Green
        if (-not (& git remote | Select-String -SimpleMatch "origin")) {
            & git remote add origin "https://github.com/$fullRepo.git"
        }
        & git push -u origin main
    }

    Write-Host "✓ Completed: $fullRepo" -ForegroundColor Green
    Pop-Location
}

foreach ($service in $services) {
    $repoName = "$Prefix-$($service.Name)"
    Init-And-Push-Repo -repoName $repoName -path $service.Path
}

Write-Host "`n=== Processing orchestration repository ===" -ForegroundColor Cyan
$orchestrationRepoName = "$Prefix-microservices-deployment"
Push-Location $root

if (-not (Test-Path ".git")) {
    & git init
    & git branch -M main
}

& git add .
$status = & git status --porcelain
if ($status) {
    & git commit -m "Initial setup: deployment and docs"
}

$rootFullRepo = "bijesh-bits/$orchestrationRepoName"
$rootRepoExists = $false
try {
    & gh repo view $rootFullRepo 2>&1 | Out-Null
    $rootRepoExists = $true
    Write-Host "Repository already exists: $rootFullRepo" -ForegroundColor Yellow
} catch {
    $rootRepoExists = $false
}

if (-not $rootRepoExists) {
    Write-Host "Creating new repository: $rootFullRepo" -ForegroundColor Green
    & gh repo create $rootFullRepo --public --source . --remote origin --push
} else {
    Write-Host "Pushing to existing repository: $rootFullRepo" -ForegroundColor Green
    if (-not (& git remote | Select-String -SimpleMatch "origin")) {
        & git remote add origin "https://github.com/$rootFullRepo.git"
    }
    & git push -u origin main
}

Write-Host "✓ Completed: $rootFullRepo" -ForegroundColor Green
Pop-Location

Write-Host "`n✅ All repositories processed successfully!" -ForegroundColor Green
Write-Host "`nRepository listing:"
& gh repo list bijesh-bits --limit 10
