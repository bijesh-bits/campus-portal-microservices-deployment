# Student Services Microservices (Local Docker Architecture)

This project implements a microservices-based Student Services system aligned with [instructions.md](instructions.md).

## Services
- `StudentService` - manages student data
- `CourseService` - manages course data
- `EnrollmentService` - manages enrollments and validates cross-service references
- `ApiGateway` - single entry point using YARP

## Architecture Highlights
- Decomposition: Business Capability
- Minimum 3 independent microservices
- Database per microservice (PostgreSQL containers)
- Inter-service communication: REST (synchronous)
- Async messaging (optional advanced): RabbitMQ event from Enrollment Service, consumed by Course Service
- API Gateway/BFF: YARP
- Versioning style: `/api/v1/...`
- Deployment model: local Docker Compose only

## Run Locally
1. Build and start all containers:

```bash
docker-compose up --build
```

2. Gateway endpoint:
- `http://localhost:5000/health`

## API Quickstart (through Gateway)
### Create student
```bash
curl -X POST http://localhost:5000/api/students \
  -H "Content-Type: application/json" \
  -d '{"fullName":"Aarav Sharma","email":"aarav@example.com"}'
```

### Create course
```bash
curl -X POST http://localhost:5000/api/courses \
  -H "Content-Type: application/json" \
  -d '{"title":"Scalable Systems","credits":4}'
```

### Create enrollment
```bash
curl -X POST http://localhost:5000/api/enrollments \
  -H "Content-Type: application/json" \
  -d '{"studentId":"<student-guid>","courseId":"<course-guid>"}'
```

### List enrollments
```bash
curl http://localhost:5000/api/enrollments
```

## RabbitMQ
- Management UI: http://localhost:15672
- Default login: guest / guest
- Queue: enrollment.created
- Local guide: [docs/rabbitmq-local-guide.md](docs/rabbitmq-local-guide.md)

## One-command demo smoke test
Run after docker compose is up:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/demo-smoke-test.ps1
```

## Submission Docs
Use [docs/submission-report-template.md](docs/submission-report-template.md) and [docs/demo-recording-script.md](docs/demo-recording-script.md).

## Publish to GitHub (after gh install)
Use a common repo prefix and run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/publish-repos.ps1 -Prefix bitsgroup1 -Visibility public
```

Detailed steps: [docs/github-publish-guide.md](docs/github-publish-guide.md)
