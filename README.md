# FocusCraft – Adaptive Productivity AI

A privacy-focused, AI-powered productivity assistant that learns user behavior, identifies unique work patterns, and automatically generates personalized productivity recommendations. Fully offline-capable with no external APIs.

## Architecture

- **Frontend**: Flutter app with BLoC state management
- **Backend**: Spring Boot GraphQL API
- **AI Engine**: Python service for behavioral analytics and insights
- **Storage**: PostgreSQL (structured data), MinIO (audio files), Qdrant (embeddings)
- **Message Queue**: RabbitMQ for async processing

## Key Features

✅ **Task Tracking**: Create, manage, and prioritize tasks
✅ **Habit Logging**: Track daily habits and routines
✅ **Mood Logging**: Record mood and energy levels
✅ **Voice Input**: Voice notes transcribed with Whisper
✅ **Behavioral Analytics**: AI-powered insights on productivity patterns
✅ **Weekly Planning**: Adaptive weekly plans based on behavior
✅ **Semantic Search**: Find tasks and sessions using natural language
✅ **Real-time Updates**: GraphQL subscriptions for live updates
✅ **Privacy-First**: All AI processing happens locally

## Technology Stack

- **Frontend**: Flutter, BLoC, graphql_flutter
- **Backend**: Spring Boot, Spring GraphQL, JPA, PostgreSQL
- **AI**: Whisper.cpp, SentenceTransformers, Llama.cpp, Qdrant
- **Infrastructure**: Docker, MinIO, RabbitMQ

## Quick Start

1. Start infrastructure:
```bash
cd docker && docker-compose up -d
```

2. Start backend:
```bash
cd backend && ./mvnw spring-boot:run
```

3. Start AI engine:
```bash
cd ai-engine && python main.py
```

4. Run Flutter app:
```bash
cd frontend && flutter run
```

## Project Structure

```
focuscraft/
├── frontend/          # Flutter application
├── backend/           # Spring Boot GraphQL API
├── ai-engine/         # Python AI processing
└── docker/            # Infrastructure services
```

