# RabbitMQ Local Guide (Beginner Friendly)

## What is already configured
- RabbitMQ service is already added in docker-compose.yml
- Management UI port: 15672
- AMQP port: 5672
- Default credentials: guest / guest
- Queue used by app: enrollment.created

## Start everything
From project root:

1. docker compose up --build

## Verify containers
1. docker compose ps

You should see:
- rabbitmq
- student-service
- course-service
- enrollment-service
- api-gateway
- 3 postgres containers

## RabbitMQ UI
Open in browser:
- http://localhost:15672

Login:
- Username: guest
- Password: guest

Where to check queue:
1. Go to Queues and Streams
2. Find enrollment.created
3. Publish happens from EnrollmentService when enrollment API is called
4. CourseService consumes this queue

## Run complete API flow
From project root:

1. powershell -ExecutionPolicy Bypass -File scripts/demo-smoke-test.ps1

Expected output:
- studentId present
- courseId present
- enrollmentId present
- enrollmentsCount >= 1
- consumedEventsCount >= 1

## Stop everything
1. docker compose down

If you want to remove volumes too:
1. docker compose down -v

## Typical memory use (local laptop)
- RabbitMQ idle: roughly 120MB to 250MB
- With light demo load: roughly 200MB to 400MB

## Why gateway still works with messaging
- Gateway routes HTTP calls to services
- Messaging is internal service-to-service async communication
- They are complementary, not competing components
