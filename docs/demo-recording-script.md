# Demo Recording Script

## Video 1: Conceptual Explanation (3-5 min)
1. Introduce team and application domain.
2. Explain decomposition strategy (Business Capability).
3. Explain service boundaries:
   - Student Service
   - Course Service
   - Enrollment Service
4. Explain DB-per-service and why it improves autonomy.
5. Explain communication model and gateway role.

## Video 2: Working System Demo (5-10 min)
1. Show project structure and independent service folders.
2. Run:
```bash
docker-compose up --build
```
3. Show containers are up.
4. Through API Gateway, execute:
   - POST `/api/students`
   - POST `/api/courses`
   - POST `/api/enrollments`
   - GET `/api/enrollments`
5. Explain that enrollment call validates student and course via inter-service REST calls.
6. Show gateway is the only external entry point.
7. Show versioning convention (`/api/v1` internally).

## Video 3: Advanced Optional (3-5 min)
1. Stop one backend service and explain fault isolation.
2. Show what still works and what fails gracefully.
3. Briefly discuss scaling and future enhancements.

## Suggested Recording Checklist
- [ ] Terminal font large enough to read
- [ ] Show commands and responses clearly
- [ ] Keep API IDs visible for enrollment step
- [ ] Keep one fallback screenshot set ready
- [ ] Mention local-only Docker constraint explicitly
