# FocusCraft Setup Guide

## Prerequisites

- **Docker & Docker Compose** (for infrastructure)
- **Java 17+** (for backend)
- **Maven 3.8+** (for backend)
- **Flutter 3.8+** (for frontend)
- **Python 3.10+** (for AI engine)
- **PostgreSQL 15** (via Docker)
- **MinIO** (via Docker)
- **Qdrant** (via Docker)
- **RabbitMQ** (via Docker)

## Step 1: Start Infrastructure

```bash
cd docker
docker-compose up -d
```

This starts:
- PostgreSQL on port 5432
- MinIO on ports 9000 (API) and 9001 (Console)
- Qdrant on ports 6333 (API) and 6334 (gRPC)
- RabbitMQ on ports 5672 (AMQP) and 15672 (Management UI)

Verify services are running:
```bash
docker-compose ps
```

## Step 2: Configure MinIO Bucket

1. Open MinIO Console: http://localhost:9001
2. Login: minioadmin / minioadmin
3. Create bucket: `focuscraft-files`

## Step 3: Setup Backend

```bash
cd backend

# Install dependencies (if needed)
./mvnw clean install

# Run application
./mvnw spring-boot:run
```

Backend will be available at:
- GraphQL API: http://localhost:8080/graphql
- GraphiQL: http://localhost:8080/graphiql

## Step 4: Setup AI Engine

```bash
cd ai-engine

# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set environment variables (optional)
export RABBITMQ_HOST=localhost
export MINIO_ENDPOINT=localhost:9000
export QDRANT_HOST=localhost
export BACKEND_URL=http://localhost:8080

# Run AI engine
python main.py
```

## Step 5: Setup Flutter Frontend

```bash
cd frontend

# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run
```

For web:
```bash
flutter run -d chrome
```

## Configuration

### Backend Configuration

Edit `backend/src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/focuscraft
    username: focuscraft
    password: focuscraft

minio:
  endpoint: http://localhost:9000
  access-key: minioadmin
  secret-key: minioadmin
  bucket-name: focuscraft-files

ai-engine:
  base-url: http://localhost:8000
```

### Flutter Configuration

Edit `frontend/lib/core/config/app_config.dart` or use environment variables:

```dart
static String get graphqlEndpoint => 'http://localhost:8080/graphql';
static String get wsEndpoint => 'ws://localhost:8080/graphql-ws';
```

## Testing the Setup

### 1. Test GraphQL API

Open GraphiQL: http://localhost:8080/graphiql

Try this query:
```graphql
query {
  tasks {
    id
    title
    priority
    status
  }
}
```

### 2. Test Flutter App

1. Launch the app
2. Navigate to Tasks screen
3. Tap "+" to create a task
4. Fill in the form and submit
5. Verify task appears in the list

### 3. Test AI Engine

The AI engine will automatically process tasks from RabbitMQ. Check logs for:
- "Waiting for messages on queue: ai.tasks"
- Processing messages when tasks are created

## Troubleshooting

### Backend won't start
- Check PostgreSQL is running: `docker ps | grep postgres`
- Verify database credentials in `application.yml`
- Check port 8080 is not in use

### Flutter can't connect
- Verify backend is running: `curl http://localhost:8080/health`
- Check GraphQL endpoint in `app_config.dart`
- Ensure CORS is configured (for web)

### AI Engine errors
- Verify RabbitMQ is running: `docker ps | grep rabbitmq`
- Check MinIO is accessible: `curl http://localhost:9000/minio/health/live`
- Verify Qdrant is running: `curl http://localhost:6333/health`

### Database connection issues
- Wait for PostgreSQL to fully start (may take 10-20 seconds)
- Check database exists: `docker exec -it focuscraft-postgres psql -U focuscraft -d focuscraft`
- Verify credentials match `application.yml`

## Development Tips

1. **Hot Reload**: Flutter supports hot reload (press `r` in terminal)
2. **GraphiQL**: Use GraphiQL to test GraphQL queries/mutations
3. **Logs**: Check backend logs for errors: `./mvnw spring-boot:run`
4. **Docker Logs**: `docker-compose logs -f [service-name]`

## Production Deployment

For production:
1. Use environment variables for all configuration
2. Set up proper database backups
3. Configure SSL/TLS
4. Use production-grade secrets management
5. Set up monitoring and logging
6. Configure reverse proxy (nginx)
7. Use container orchestration (Kubernetes)

## Next Steps

- See `PROJECT_SUMMARY.md` for feature overview
- Check `README.md` for quick start
- Review code structure in respective directories

