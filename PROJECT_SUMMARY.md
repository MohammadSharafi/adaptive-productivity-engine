# FocusCraft - Adaptive Productivity AI

## Project Overview

FocusCraft is a privacy-focused, AI-powered productivity assistant that learns user behavior, identifies unique work patterns, and automatically generates personalized productivity recommendations. The system is fully offline-capable with no external APIs, ensuring maximum privacy and control.

## Architecture

### Three-Layer Architecture

1. **Flutter Frontend** (Mobile Client)
   - DDD (Domain-Driven Design) architecture
   - BLoC pattern for state management
   - GraphQL for API communication
   - Material 3 UI with animations and charts

2. **Spring Boot Backend** (GraphQL API)
   - Clean Architecture (Domain, Application, Infrastructure, Presentation)
   - GraphQL API with queries, mutations, and subscriptions
   - PostgreSQL for structured data
   - MinIO for file storage
   - RabbitMQ for async task processing

3. **Python AI Engine** (Behavioral Analytics)
   - Whisper.cpp for voice transcription
   - SentenceTransformers for embeddings
   - Qdrant for vector storage and semantic search
   - Behavioral analytics algorithms
   - Weekly plan generation

## Key Features

### ✅ Implemented

- **Task Management**
  - Create, update, complete, and delete tasks
  - Priority levels (Low, Medium, High, Urgent)
  - Task status tracking (Todo, In Progress, Blocked, Completed)
  - Energy level and difficulty ratings
  - Due date management
  - Overdue task detection

- **Habit Tracking**
  - Create and manage habits
  - Daily/Weekly/Monthly frequency
  - Streak tracking
  - Completion rate calculation

- **Mood Logging**
  - Daily mood tracking
  - Energy and stress level monitoring
  - Productivity score calculation

- **Productivity Sessions**
  - Start/stop session tracking
  - Focus score measurement
  - Distraction logging

- **Analytics Dashboard**
  - Productivity peaks visualization
  - Habit correlation analysis
  - Weekly summary statistics
  - Task insights

- **Voice Logs**
  - Voice note transcription (Whisper)
  - Semantic search support

### 🚧 In Progress / Planned

- Weekly adaptive planning
- Advanced behavioral analytics
- Cross-device sync
- Offline-first support
- Natural language task creation

## Technology Stack

### Frontend
- **Flutter** 3.8+
- **BLoC** for state management
- **graphql_flutter** for API
- **fl_chart** for data visualization
- **shimmer** for loading states

### Backend
- **Spring Boot** 3.2.0
- **Spring GraphQL** 1.2.0
- **PostgreSQL** 15
- **JPA/Hibernate** for ORM
- **MinIO** for object storage
- **RabbitMQ** for messaging

### AI Engine
- **Python** 3.10+
- **Whisper** for speech-to-text
- **SentenceTransformers** for embeddings
- **Qdrant** for vector database
- **Pandas/Scikit-learn** for analytics

### Infrastructure
- **Docker Compose** for local development
- **PostgreSQL** for metadata
- **MinIO** for files
- **Qdrant** for vectors
- **RabbitMQ** for queues

## Project Structure

```
focuscraft/
├── frontend/              # Flutter application
│   ├── lib/
│   │   ├── domain/        # Domain layer (entities, repositories, use cases)
│   │   ├── data/          # Data layer (models, data sources, repositories)
│   │   ├── presentation/  # Presentation layer (BLoC, screens, widgets)
│   │   ├── core/          # Core utilities (error handling, config)
│   │   └── graphql/       # GraphQL queries, mutations, subscriptions
│   └── pubspec.yaml
│
├── backend/               # Spring Boot application
│   ├── src/main/java/com/focuscraft/
│   │   ├── domain/         # Domain models and repositories
│   │   ├── application/    # Use cases and DTOs
│   │   ├── infrastructure/ # JPA, external services
│   │   └── presentation/  # GraphQL resolvers
│   └── pom.xml
│
├── ai-engine/             # Python AI service
│   ├── main.py            # Main AI engine
│   └── requirements.txt
│
└── docker/                # Infrastructure
    └── docker-compose.yml
```

## Data Flow

1. **User creates task** → Flutter sends GraphQL mutation
2. **Backend receives** → Saves to PostgreSQL, publishes to RabbitMQ
3. **AI Engine processes** → Generates embeddings, stores in Qdrant
4. **Backend updates** → Emits GraphQL subscription
5. **Flutter receives** → UI updates in real-time

## Quick Start

### Prerequisites
- Docker & Docker Compose
- Java 17+
- Flutter 3.8+
- Python 3.10+

### Setup

1. **Start Infrastructure**
```bash
cd docker && docker-compose up -d
```

2. **Start Backend**
```bash
cd backend && ./mvnw spring-boot:run
```

3. **Start AI Engine**
```bash
cd ai-engine && pip install -r requirements.txt && python main.py
```

4. **Run Flutter App**
```bash
cd frontend && flutter run
```

## Development Status

- ✅ Project structure
- ✅ Domain models (Task, Habit, MoodLog, etc.)
- ✅ GraphQL schema
- ✅ Flutter DDD architecture
- ✅ BLoC state management
- ✅ Data layer implementation
- ✅ Backend infrastructure
- ✅ Task CRUD operations
- ✅ Analytics dashboard
- ✅ Task creation form
- 🚧 Habit and Mood screens (UI only)
- 🚧 Weekly planning
- 🚧 Voice log processing
- 🚧 Advanced analytics

## Next Steps

1. Complete Habit and Mood screen implementations
2. Add voice recording and upload functionality
3. Implement weekly plan generation UI
4. Add more analytics visualizations
5. Implement offline-first support
6. Add unit tests
7. Performance optimization
8. Production deployment guide

## License

Private project - All rights reserved

