# Microservices Architecture Assignment – Implementation Instructions

## Objective
Design, implement, and demonstrate a microservices-based system with proper architectural practices including service decomposition, independent deployment, communication, and containerization.

---

# ✅ 1. Domain Selection & Service Decomposition (Design + Documentation)

## Task
- Select an application domain (e.g., e-commerce, food ordering, healthcare, banking, LMS, student services).
- Identify **minimum 3 microservices**.

## Requirements
- Use ONE decomposition strategy:
  - Business Capability
  - Domain-Driven Design (DDD subdomains)

## Deliverables
- Document:
  - Selected domain
  - Identified microservices
  - Justification of boundaries
- No coding required here

---

# ✅ 2. Microservice Implementation (Core Coding Task)

## Task
Implement **at least 3 independent microservices**.

## Each service must:
- Have **single responsibility**
- Expose its own API
- Be independently developed & tested
- Be in a **separate Git repository**
- Be deployable independently

## Deliverables
- 3 independent services (separate repos or folders)
- Running APIs

---

# ✅ 3. Service APIs & Collaboration (Design + Partial Implementation)

## Task
Define and implement service APIs.

## For each service:
- Responsibilities
- API endpoints
- Collaboration with other services
- Interaction types:
  - Command
  - Query
  - Event

## Deliverables
- API definitions (OpenAPI / documentation)
- Basic implementation of endpoints
- Interaction diagram (recommended)

---

# ✅ 4. Database Strategy & Data Patterns (Design + Optional Implementation)

## Task
Design database architecture.

## Requirements
- Prefer **Database per Microservice pattern**
- Each service must:
  - Own its own data
  - Use appropriate DB technology

## Optional Advanced Patterns (Documentation + Optional implementation):
- CQRS
- Event Sourcing
- Saga

## Deliverables
- Database design justification
- ER diagrams / schema
- Explain applied patterns

---

# ✅ 5. Inter-Service Communication (Critical Implementation)

## Task
Implement low-coupled communication between services.

## Choose one or more:
- REST ✅ (Simplest)
- GraphQL
- gRPC
- Async Messaging (Kafka, RabbitMQ, etc.)

## Must explain:
- Communication type:
  - One-to-One / One-to-Many
  - Synchronous / Asynchronous
- Why chosen approach fits use case
- How it reduces coupling

## Deliverables
- Working communication flow between services
- Example API calls or messaging setup
- Explanation (documentation)

---

# ✅ 6. API Gateway / BFF (Mandatory Implementation)

## Task
Introduce entry layer.

## Options:
- API Gateway
- Backend for Frontends (BFF)

## Responsibilities:
- Single entry point
- Route requests to services
- Hide internal architecture

## Optional capabilities:
- Auth / Authorization
- Logging / Metrics
- Caching / Rate limiting

## Deliverables
- Implement gateway layer
- Demonstrate routing to services

---

# ✅ 7. API Versioning Strategy (Documentation Only)

## Task
Define versioning approach.

## Must include:
- Why versioning is needed
- What is a breaking change
- Non-breaking changes handling
- Semantic versioning:
  - Major
  - Minor
  - Patch

## Deliverables
- Written strategy
- Optional: versioned API example

---

# ✅ 8. Docker Containerization (Implementation)

## Task
Containerize all services.

## Requirements:
- Each microservice runs in **separate Docker container**
- Include:
  - Dockerfiles
  - Build instructions

## Deliverables
- Docker setup
- Screenshots or proof of running containers

---


# ⚠️ Implementation Constraint: Local Docker-Based Architecture Only

## Context

This assignment must be designed and implemented using a **local-first, containerized architecture**.  
**Cloud deployment (Azure, AWS, GCP, or any paid/free cloud platform) is NOT part of this implementation.**

## Mandatory Constraint

All components of the system MUST:

- Run locally using **Docker containers**
- Be orchestrated using **Docker Compose**
- Be fully functional without any dependency on external cloud infrastructure

## What This Means

The implementation MUST follow:

- Each microservice runs in its own container
- API Gateway runs as a container
- Databases run as containers (one per service if using DB-per-service pattern)
- Inter-service communication happens via container networking (Docker network)

## Explicitly NOT Allowed

The following should NOT be included in the implementation plan:

- Azure services (App Service, AKS, Service Bus, etc.)
- AWS services (EC2, ECS, Lambda, SQS, etc.)
- Any cloud-based deployment pipelines
- Kubernetes (unless purely local e.g., Minikube — optional only)

## Deployment Model

The entire system must be startable using a single command:

```bash
docker-compose up

## Technology Preference

Preferred technology stack:

- Backend: .NET (ASP.NET Core Web API)
- Communication: REST (primary), optional async pattern
- API Gateway: YARP or Ocelot
- Database: PostgreSQL / SQL Server (containerized)
- Containerization: Docker + Docker Compose


# 📝 Submission Deliverables (VERY IMPORTANT)

## A. Documentation (Major Component)

Include:
- Team details
- Contribution per member
- Application overview
- Architecture diagram
- Decomposition rationale
- API design
- Database design
- Communication approach
- API Gateway/BFF design
- Versioning strategy
- Docker steps
- Screenshots
- GitHub repo links

---

## B. Demo Video 1 (Conceptual Explanation)
Explain:
- Application overview
- Microservices identified
- Decomposition approach
- Database selection
- Communication design

---

## C. Demo Video 2 (Working System)
Show:
- Services running independently
- API communication
- Gateway/BFF working
- Versioning example
- Docker deployment

---

## D. Demo Video 3 (Advanced/Optional)
Demonstrate:
- Scalability
- Fault isolation
- Optional:
  - Kubernetes / Minikube
  - Cloud deployment

---

## E. Final Packaging
- Zip file format:
- Include everything:
- Code
- Docs
- Videos
- Each member must submit

---

# ✅ Evaluation Criteria (Important for Prioritization)

| Area | Marks |
|------|------|
| Domain & decomposition | 2 |
| Microservices implementation | 2 |
| API design & collaboration | 2 |
| Database strategy | 2 |
| Communication | 3 |
| API Gateway / BFF | 2 |
| Versioning | 1 |
| Docker | 1 |
| **Total** | **15** |

---

# ✅ Suggested Implementation Strategy (For GH Copilot Agent)

1. Start with domain & service design
2. Define APIs (contract-first)
3. Build services independently
4. Add database per service
5. Implement inter-service communication
6. Add API Gateway
7. Containerize using Docker
8. Prepare documentation + demos

---

# ✅ Key Constraints

- Minimum 3 microservices mandatory
- Must be independently deployable
- Must demonstrate communication
- Must use Docker
- Documentation is **as important as coding**
