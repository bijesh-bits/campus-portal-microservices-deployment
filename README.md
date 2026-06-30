# Student Services Microservices (Local Docker Architecture)

This project implements a microservices-based Student Services system aligned with [instructions.md](instructions.md).

## 🎨 Features
- **3 Independent Microservices** - Student, Course, Enrollment
- **API Gateway** - Single entry point with YARP
- **Database per Service** - PostgreSQL instances (db-per-service pattern)
- **Web Dashboard** - Professional UI for easy demonstration
- **REST Communication** - Synchronous service-to-service calls
- **RabbitMQ Messaging** - Optional async events (advanced feature)
- **Docker Deployment** - Fully containerized local setup

## Services
- `StudentService` - manages student data
- `CourseService` - manages course data  
- `EnrollmentService` - manages enrollments and validates cross-service references
- `ApiGateway` - single entry point using YARP
- `WebUI` - professional dashboard for demonstrations (NEW!)

## Architecture Highlights
- Decomposition: Business Capability
- Minimum 3 independent microservices
- Database per microservice (PostgreSQL containers)
- Inter-service communication: REST (synchronous)
- Async messaging (optional advanced): RabbitMQ event from Enrollment Service, consumed by Course Service
- API Gateway/BFF: YARP
- Versioning style: `/api/v1/...`
- Deployment model: local Docker Compose only

## 🚀 Run Locally

### Start Everything
```bash
docker-compose up --build
```

This starts:
- 3 microservices (ports 5001-5003)
- 1 API Gateway (port 5000)
- 1 Web Dashboard (port 8080)
- 3 PostgreSQL databases (ports 5432-5434)
- 1 RabbitMQ broker (ports 5672, 15672)
- Total: 9 containers

### Access the Dashboard
Open **http://localhost:8080** in your browser to access the professional dashboard.

### Check Health
```bash
curl http://localhost:5000/api/students
```

## 🎯 Web Dashboard

A modern, professional UI for managing the system:

✨ **Features**:
- Dashboard with real-time statistics
- 3 tabs: Students | Courses | Enrollments
- Create new records via forms
- View all data in responsive tables
- Real-time API integration
- Auto-refresh every 5 seconds
- Beautiful gradient UI
- Success/error notifications

📍 **Location**: http://localhost:8080
📁 **Source**: [web-ui/](web-ui/) directory

### How to Use
1. Open http://localhost:8080
2. Go to Students tab → Create a student
3. Go to Courses tab → Create a course
4. Go to Enrollments tab → Select student + course → Enroll
5. Watch real-time updates across all tabs!

## API Quickstart (through Gateway)

### Via Web Dashboard (Recommended) ⭐
Simply go to **http://localhost:8080** and use the forms!

### Via cURL (alternative)

#### Create student
```bash
curl -X POST http://localhost:5000/api/students \
  -H "Content-Type: application/json" \
  -d '{"full_name":"Aarav Sharma","email":"aarav@example.com"}'
```

#### Create course
```bash
curl -X POST http://localhost:5000/api/courses \
  -H "Content-Type: application/json" \
  -d '{"title":"Scalable Systems","credits":4}'
```

#### Create enrollment
```bash
curl -X POST http://localhost:5000/api/enrollments \
  -H "Content-Type: application/json" \
  -d '{"student_id":"<student-guid>","course_id":"<course-guid>"}'
```

#### List enrollments
```bash
curl http://localhost:5000/api/enrollments
```

## 🐰 RabbitMQ
- Management UI: http://localhost:15672
- Default login: guest / guest
- Queue: enrollment.created
- Local guide: [docs/rabbitmq-local-guide.md](docs/rabbitmq-local-guide.md)

## 🧪 One-command Demo

Run after docker compose is up:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/demo-smoke-test.ps1
```

This automatically:
- Creates a student
- Creates a course
- Creates an enrollment
- Verifies RabbitMQ event consumption
- Outputs success confirmation

## 📋 Submission Docs
- Template: [docs/submission-report-template.md](docs/submission-report-template.md)
- Submission report: [docs/submission-report.md](docs/submission-report.md)
- Demo recording guide: [docs/demo-recording-script.md](docs/demo-recording-script.md)

## 🌐 GitHub Repositories
All services and deployment configs published to GitHub:
- Student Service: https://github.com/bijesh-bits/campus-portal-student-service
- Course Service: https://github.com/bijesh-bits/campus-portal-course-service
- Enrollment Service: https://github.com/bijesh-bits/campus-portal-enrollment-service
- API Gateway: https://github.com/bijesh-bits/campus-portal-api-gateway
- Web UI: https://github.com/bijesh-bits/campus-portal-web-ui
- Deployment & Docs: https://github.com/bijesh-bits/campus-portal-microservices-deployment

## 📖 Documentation
- [Web UI Guide](web-ui/README.md) - Dashboard features and usage
- [RabbitMQ Setup](docs/rabbitmq-local-guide.md) - Message broker configuration
- [GitHub Publishing](docs/github-publish-guide.md) - Repository setup instructions
- [Demo Recording](docs/demo-recording-script.md) - Video shooting guide
- [Submission Report](docs/submission-report.md) - Complete assessment template

## Tech Stack
- **Backend**: C# ASP.NET Core (.NET 10.0)
- **Databases**: PostgreSQL 16 (3 instances)
- **Message Broker**: RabbitMQ 3
- **API Gateway**: YARP 2.3.0
- **Frontend**: HTML5 + Bootstrap 5 + Vanilla JavaScript
- **Containerization**: Docker + Docker Compose
- **Versioning**: /api/v1 routes

## Project Structure
```
├── src/
│   ├── StudentService/
│   ├── CourseService/
│   ├── EnrollmentService/
│   └── ApiGateway/
├── web-ui/                    # NEW: Professional dashboard
│   ├── index.html
│   ├── Dockerfile
│   └── nginx.conf
├── docs/
│   ├── submission-report.md
│   ├── demo-recording-script.md
│   ├── rabbitmq-local-guide.md
│   └── github-publish-guide.md
├── scripts/
│   ├── demo-smoke-test.ps1
│   └── publish-repos.ps1
├── docker-compose.yml         # UPDATED: Now includes web-ui service
└── README.md
```

## Verification Checklist
- [x] Minimum 3 microservices implemented
- [x] Database per service (3 PostgreSQL instances)
- [x] API Gateway (YARP)
- [x] Inter-service REST communication
- [x] Async messaging (RabbitMQ)
- [x] API versioning (/api/v1)
- [x] Docker Compose deployment
- [x] Professional web dashboard
- [x] GitHub repositories published
- [x] Documentation complete
- [x] Demo scripts included

---

**For assignment submission**: See [docs/submission-report.md](docs/submission-report.md)

**Team**: Bijesh Nair, Girish Patil, Ritika Prasad
