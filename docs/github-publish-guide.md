# GitHub Publish Guide

## Prerequisite
- GitHub CLI installed (`gh --version`)
- Logged in (`gh auth login`)

## Recommended repo naming
Use one common prefix for all repositories.

Example prefix: `bitsgroup1`

Generated repos:
- `bitsgroup1-student-service`
- `bitsgroup1-course-service`
- `bitsgroup1-enrollment-service`
- `bitsgroup1-api-gateway`
- `bitsgroup1-microservices-deployment`

## One-command publish
From project root:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish-repos.ps1 -Prefix bitsgroup1 -Visibility public
```

## If gh asks for authentication
Run:

```powershell
gh auth login
```

Then re-run publish script.

## Verify repos

```powershell
gh repo list bijesh-bits --limit 20
```
