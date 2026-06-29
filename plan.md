# Implementation Plan (From instructions.md)

## Domain and Decomposition
- Domain: Student Services (course registration)
- Decomposition strategy: Business Capability
- Services:
  - Student Service: student profile lifecycle
  - Course Service: course catalog lifecycle
  - Enrollment Service: enrollment command/query workflows
- Entry layer:
  - API Gateway (YARP)

## Development Plan
1. Define API contracts with Command/Query/Event mapping.
2. Implement each service independently in separate project folders.
3. Apply database-per-service using separate PostgreSQL instances.
4. Implement inter-service REST communication:
   - Enrollment Service validates student and course existence before enrollment.
5. Add gateway routing as single external entry point.
6. Add API versioning strategy and v1 route conventions.

## Deployment Plan (Local Docker-Only)
1. Dockerfile per service and gateway.
2. Docker Compose for all services and databases.
3. Internal networking by container DNS names.
4. Single command startup:
   - `docker-compose up --build`

## Documentation Plan
1. Team details and contribution split.
2. Architecture overview and decomposition rationale.
3. Service APIs and collaboration matrix.
4. Database architecture and ownership justification.
5. Communication type and low-coupling rationale.
6. Gateway routing design.
7. Versioning strategy.
8. Docker run steps and screenshots.
9. GitHub links and final evidence checklist.

## Demo Recording Instructions
### Video 1 (Conceptual)
- Explain domain, decomposition strategy, service boundaries, DB-per-service, and communication model.

### Video 2 (Working)
- Show independent services.
- Run `docker-compose up --build`.
- Demonstrate:
  - create student
  - create course
  - create enrollment through gateway
  - fetch enrollments
- Show gateway routes and running containers.

### Video 3 (Optional Advanced)
- Demonstrate fault isolation (stop one service and explain behavior).
- Optional scalability/local orchestration ideas.

## Clarifications Needed from Team
- Team member names and contribution mapping.
- Final repository links for submission report.
- Whether optional async messaging should be included.
