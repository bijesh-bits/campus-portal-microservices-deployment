param(
    [Parameter(Mandatory = $false)]
    [string]$Prefix = "campus-portal"
)

$ErrorActionPreference = "Stop"

Write-Host "GitHub CLI verification..."
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

foreach ($service in $services) {
    $repoName = "$Prefix-$($service.Name)"
    $fullPath = Join-Path $root $service.Path
    
    Write-Host "=== Processing $repoName ===" -ForegroundColor Cyan
    
    if (-not (Test-Path $fullPath)) {
        Write-Host "Path does not exist: $fullPath" -ForegroundColor Red
        continue
    }
    
    Push-Location $fullPath
    
    # Initialize git repo if needed
    if (-not (Test-Path ".git")) {
        Write-Host "Initializing git repository..."
        & git init
        & git branch -M main
    }
    
    # Create .gitignore if it doesn't exist
    if (-not (Test-Path ".gitignore")) {
        Write-Host "Creating .gitignore..."
        @"
bin/
obj/
.vs/
.vscode/
*.user
"@ | Set-Content -Path ".gitignore"
    }
    
    # Create README if it doesn't exist
    if (-not (Test-Path "README.md")) {
        Write-Host "Creating README.md..."
        "# $repoName`n`nMicroservice from campus-portal student enrollment system." | Set-Content -Path "README.md"
    }
    
    # Stage and commit
    & git add .
    $status = & git status --porcelain
    if ($status) {
        Write-Host "Committing initial setup..."
        & git commit -m "Initial setup: $repoName"
    }
    
    # Check if repo exists on GitHub
    $fullRepo = "bijesh-bits/$repoName"
    $repoExists = $false
    
    $checkRepo = & gh repo view $fullRepo 2>&1
    if ($LASTEXITCODE -eq 0) {
        $repoExists = $true
        Write-Host "Repository already exists: $fullRepo" -ForegroundColor Yellow
    }
    
    # Create or push
    if (-not $repoExists) {
        Write-Host "Creating new repository on GitHub..."
        & gh repo create $fullRepo --public --source . --remote origin --push
    } else {
        Write-Host "Pushing to existing repository..."
        $remoteExists = & git remote | Select-String "origin" -ErrorAction SilentlyContinue
        if (-not $remoteExists) {
            & git remote add origin "https://github.com/$fullRepo.git"
        }
        & git push -u origin main
    }
    
    Write-Host "✓ Completed: $fullRepo" -ForegroundColor Green
    Pop-Location
    Write-Host ""
}

# Process root deployment repo
Write-Host "=== Processing $Prefix-microservices-deployment ===" -ForegroundColor Cyan
$orchestrationRepoName = "$Prefix-microservices-deployment"
Push-Location $root

if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository at root..."
    & git init
    & git branch -M main
}

& git add .
$status = & git status --porcelain
if ($status) {
    Write-Host "Committing deployment setup..."
    & git commit -m "Initial setup: deployment and docs"
}

$rootFullRepo = "bijesh-bits/$orchestrationRepoName"
$rootRepoExists = $false

$checkRepo = & gh repo view $rootFullRepo 2>&1
if ($LASTEXITCODE -eq 0) {
    $rootRepoExists = $true
    Write-Host "Repository already exists: $rootFullRepo" -ForegroundColor Yellow
}

if (-not $rootRepoExists) {
    Write-Host "Creating new root repository on GitHub..."
    & gh repo create $rootFullRepo --public --source . --remote origin --push
} else {
    Write-Host "Pushing to existing root repository..."
    $remoteExists = & git remote | Select-String "origin" -ErrorAction SilentlyContinue
    if (-not $remoteExists) {
        & git remote add origin "https://github.com/$rootFullRepo.git"
    }
    & git push -u origin main
}

Write-Host "✓ Completed: $rootFullRepo" -ForegroundColor Green
Pop-Location

Write-Host "`n✅ All repositories processed successfully!" -ForegroundColor Green
Write-Host "`nRepository listing:`n"
& gh repo list bijesh-bits --limit 10
