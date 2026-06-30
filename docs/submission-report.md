# Microservices Assignment Submission Report

## 1. Team Details
- Team members:
  - Bijesh Nair
  - Girish Patil
  - Ritika Prasad
- Contribution split:
  - Bijesh Nair: 
  - Girish Patil: 
  - Ritika Prasad: 

## 2. Application Overview
- Domain: Student Services (Course Registration)
- Problem statement: Build independently deployable services for student, course, and enrollment workflows with local Docker-only deployment.
- Scope: 3 microservices + API Gateway + DB-per-service + REST collaboration.

## 3. Domain Selection and Service Decomposition
- Decomposition strategy used: Business Capability
- Services and boundaries:
  - Student Service: student profile lifecycle and ownership
  - Course Service: course catalog lifecycle and ownership
  - Enrollment Service: enrollment workflow and cross-service coordination
- Boundary justification:
  - Each service owns one business capability and one database.

## 4. Microservice Implementation
- Service folders/repositories:
  - StudentService
  - CourseService
  - EnrollmentService
  - ApiGateway
- Independent deployment proof:
  - Each service has its own project and Dockerfile.

## 5. Service APIs and Collaboration
- API style: REST
- Collaboration:
  - Command: create enrollment
  - Query: student/course existence checks
  - Event: optional (not implemented in core)
- Collaboration flow:
  - Enrollment Service calls Student and Course services before writing enrollment.

## 6. Database Strategy and Data Patterns
- Pattern: Database per microservice
- Technology: PostgreSQL containers
- Ownership:
  - student-db for Student Service
  - course-db for Course Service
  - enrollment-db for Enrollment Service

## 7. Inter-Service Communication
- Type: One-to-one, synchronous REST
- Why low coupling:
  - Enrollment only depends on service contracts, not direct database access.

## 8. API Gateway / BFF
- Technology: YARP
- Role:
  - Single entry point
  - Route mapping to internal services

## 9. API Versioning Strategy
- Route convention: /api/v1
- Breaking change: route or contract incompatible change
- Non-breaking change: additive fields/endpoints
- Semantic versioning:
  - Major: breaking
  - Minor: backward-compatible feature
  - Patch: fixes

## 10. Docker Containerization
- Startup command:
```bash
docker-compose up --build
```
- Components:
  - 3 service containers
  - 1 gateway container
  - 3 database containers

## 11. Screenshots and Proof
- Add screenshots for:
  - container list
  - API calls and responses
  - gateway routing
  - logs

## 12. GitHub Links
- Student Service repo: https://github.com/bijesh-bits/campus-portal-student-service
- Course Service repo: https://github.com/bijesh-bits/campus-portal-course-service
- Enrollment Service repo: https://github.com/bijesh-bits/campus-portal-enrollment-service
- API Gateway repo: https://github.com/bijesh-bits/campus-portal-api-gateway
- Web UI repo: https://github.com/bijesh-bits/campus-portal-web-ui
- Orchestration & Deployment repo: https://github.com/bijesh-bits/campus-portal-microservices-deployment

## 13. Final Checklist
- [ ] Minimum 3 services
- [ ] Independent services
- [ ] API collaboration demonstrated
- [ ] DB-per-service
- [ ] Gateway implemented
- [ ] Versioning documented
- [ ] Dockerized locally
- [ ] All demos recorded
