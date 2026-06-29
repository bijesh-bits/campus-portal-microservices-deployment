param(
    [string]$Prefix = "campus-portal"
)

Write-Host "GitHub CLI verification..."
gh auth status

Write-Host "`nPublishing repositories with prefix: $Prefix`n"

Set-Location "D:\__Projects\BITS Pilani\Scalable_Project"

$root = Get-Location

$services = @(
    @{Name = "student-service"; Path = "src/StudentService"},
    @{Name = "course-service"; Path = "src/CourseService"},
    @{Name = "enrollment-service"; Path = "src/EnrollmentService"},
    @{Name = "api-gateway"; Path = "src/ApiGateway"}
)

foreach ($svc in $services) {
    $repoName = "$Prefix-$($svc.Name)"
    $svcPath = $svc.Path
    $fullPath = Join-Path $root $svcPath
    
    Write-Host "Processing: $repoName" -ForegroundColor Green
    
    if (-not (Test-Path $fullPath)) {
        Write-Host "Path not found: $fullPath" -ForegroundColor Red
        continue
    }
    
    Push-Location $fullPath
    
    if (-not (Test-Path ".git")) {
        git init
        git branch -M main
    }
    
    if (-not (Test-Path ".gitignore")) {
        "bin/", "obj/", ".vs/", ".vscode/", "*.user" | Out-File .gitignore
    }
    
    if (-not (Test-Path "README.md")) {
        "# $repoName" | Out-File README.md
    }
    
    git add .
    $status = git status --porcelain
    if ($status) {
        git commit -m "Initial: $repoName"
    }
    
    $fullRepo = "bijesh-bits/$repoName"
    
    $exists = gh repo view $fullRepo 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Repo exists, pushing..." -ForegroundColor Yellow
        if (-not (git remote -v | Select-String origin)) {
            git remote add origin "https://github.com/$fullRepo.git"
        }
        git push -u origin main 2>$null
    } else {
        Write-Host "  Creating repo..." -ForegroundColor Cyan
        gh repo create $fullRepo --public --source . --remote origin --push
    }
    
    Write-Host "  ✓ Done" -ForegroundColor Green
    Pop-Location
    Write-Host ""
}

# Root orchestration repo
Write-Host "Processing: $Prefix-microservices-deployment" -ForegroundColor Green
Push-Location $root

if (-not (Test-Path ".git")) {
    git init
    git branch -M main
}

git add .
$status = git status --porcelain
if ($status) {
    git commit -m "Initial: deployment"
}

$rootRepo = "bijesh-bits/$Prefix-microservices-deployment"
$exists = gh repo view $rootRepo 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  Repo exists, pushing..." -ForegroundColor Yellow
    if (-not (git remote -v | Select-String origin)) {
        git remote add origin "https://github.com/$rootRepo.git"
    }
    git push -u origin main 2>$null
} else {
    Write-Host "  Creating repo..." -ForegroundColor Cyan
    gh repo create $rootRepo --public --source . --remote origin --push
}

Write-Host "  ✓ Done" -ForegroundColor Green
Pop-Location

Write-Host "`n✅ Complete!" -ForegroundColor Green
gh repo list bijesh-bits --limit 10
