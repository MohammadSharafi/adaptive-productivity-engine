# FocusCraft – Adaptive Productivity AI

<div align="center">

![FocusCraft](https://img.shields.io/badge/FocusCraft-Adaptive%20Productivity-blue?style=for-the-badge)
![Privacy](https://img.shields.io/badge/Privacy-First-green?style=for-the-badge)
![Offline](https://img.shields.io/badge/Offline-Capable-orange?style=for-the-badge)

**A privacy-focused, AI-powered productivity assistant that learns your behavior and generates personalized recommendations**

[Features](#-key-features) • [Architecture](#-architecture) • [Quick Start](#-quick-start) • [Documentation](#-documentation)

</div>

---

## 📖 Description

FocusCraft is an intelligent productivity assistant that adapts to your unique work patterns. Unlike traditional productivity apps that rely on cloud-based AI services, FocusCraft runs entirely on your infrastructure, ensuring complete privacy and data ownership.

### What Makes FocusCraft Different?

🎯 **Adaptive Intelligence**: Learns from your behavior patterns, productivity peaks, and work habits to provide personalized insights

🔒 **Privacy-First**: All AI processing happens locally - no data leaves your infrastructure

🧠 **Behavioral Analytics**: Understands when you're most productive, which tasks drain energy, and how habits affect your output

📊 **Data-Driven Insights**: Visual analytics show productivity trends, habit correlations, and focus patterns

🎨 **Beautiful UI**: Modern Flutter interface with smooth animations and intuitive navigation

⚡ **Real-Time Updates**: GraphQL subscriptions keep your data synchronized across all devices

## 🎯 Key Features

### ✅ Task Management
- **Smart Task Tracking**: Create tasks with priority, energy level, and difficulty ratings
- **Status Management**: Track tasks from creation to completion
- **Overdue Detection**: Automatic identification of overdue tasks
- **Time Estimation**: Set and track estimated vs actual duration

### ✅ Habit Tracking
- **Flexible Frequencies**: Daily, weekly, or monthly habit tracking
- **Streak Monitoring**: Visual streak counters to maintain motivation
- **Completion Analytics**: Track habit completion rates over time
- **Correlation Insights**: See how habits impact productivity and mood

### ✅ Mood & Energy Logging
- **Daily Mood Tracking**: Log your mood with emoji-based interface
- **Energy & Stress Levels**: Monitor energy (1-10) and stress levels
- **Productivity Scoring**: Automatic calculation of productivity scores
- **Trend Analysis**: Visualize mood and energy trends over time

### ✅ Productivity Sessions
- **Focus Time Tracking**: Start and stop productivity sessions
- **Focus Score Measurement**: Rate your focus level (1-10) per session
- **Distraction Logging**: Track what distracts you during work
- **Session Analytics**: Understand your most productive time blocks

### ✅ Behavioral Analytics
- **Productivity Peaks**: Identify your most productive hours of the day
- **Habit Correlations**: See which habits boost productivity and mood
- **Focus Patterns**: Discover your best days and time blocks for deep work
- **Task Insights**: Understand task difficulty, energy drain, and completion patterns
- **Weekly Summaries**: Get comprehensive weekly productivity reports

### ✅ AI-Powered Features
- **Voice Transcription**: Record voice notes transcribed with Whisper
- **Semantic Search**: Find tasks and sessions using natural language
- **Weekly Planning**: AI-generated adaptive weekly plans
- **Personalized Recommendations**: Task priorities, time blocks, and habit suggestions

### ✅ Privacy & Security
- **Local AI Processing**: All models run on your infrastructure
- **No External APIs**: Zero dependency on cloud AI services
- **Self-Hosted**: Complete control over your data
- **Offline-First**: Works without internet connection

## 🏗️ Architecture

FocusCraft follows a clean, three-layer architecture:

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter Frontend                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Domain  │  │   Data   │  │Presentation│            │
│  │  (DDD)   │  │  Layer   │  │   (BLoC)   │            │
│  └──────────┘  └──────────┘  └──────────┘             │
└──────────────────────┬──────────────────────────────────┘
                       │ GraphQL
┌──────────────────────▼──────────────────────────────────┐
│              Spring Boot Backend                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Domain  │  │Application│  │Infrastructure│         │
│  │  Layer   │  │  Layer    │  │   Layer      │         │
│  └──────────┘  └──────────┘  └──────────┘             │
└──────┬──────────────────┬───────────────────┬──────────┘
       │                  │                   │
   PostgreSQL          RabbitMQ            MinIO
   (Metadata)        (Messages)          (Files)
       │                  │                   │
       └──────────────────┴───────────────────┘
                          │
┌─────────────────────────▼─────────────────────────────────┐
│              Python AI Engine                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ Whisper  │  │Sentence   │  │  Qdrant  │             │
│  │ (Speech) │  │Transformers│  │ (Vectors)│            │
│  └──────────┘  └──────────┘  └──────────┘             │
└─────────────────────────────────────────────────────────┘
```

### Technology Stack

**Frontend**
- Flutter 3.8+ with Material 3
- BLoC pattern for state management
- GraphQL for API communication
- fl_chart for data visualization
- shimmer for loading states

**Backend**
- Spring Boot 3.2.0
- Spring GraphQL 1.2.0
- PostgreSQL 15 for metadata
- JPA/Hibernate for ORM
- Clean Architecture pattern

**AI Engine**
- Python 3.10+
- Whisper for speech-to-text
- SentenceTransformers for embeddings
- Qdrant for vector storage
- Pandas/Scikit-learn for analytics

**Infrastructure**
- Docker Compose for orchestration
- MinIO for object storage
- RabbitMQ for message queuing
- PostgreSQL for relational data
- Qdrant for vector database

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Java 17+
- Flutter 3.8+
- Python 3.10+

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/MohammadSharafi/adaptive-productivity-engine.git
cd adaptive-productivity-engine
```

2. **Start infrastructure services**
```bash
cd docker
docker-compose up -d
```

3. **Start the backend**
```bash
cd ../backend
./mvnw spring-boot:run
```

4. **Start the AI engine**
```bash
cd ../ai-engine
pip install -r requirements.txt
python main.py
```

5. **Run the Flutter app**
```bash
cd ../frontend
flutter pub get
flutter run
```

### Verify Installation

- **Backend**: http://localhost:8080/graphiql
- **MinIO Console**: http://localhost:9001 (minioadmin/minioadmin)
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)
- **Qdrant Dashboard**: http://localhost:6333/dashboard

## 📚 Documentation

- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - Detailed architecture and features
- **[SETUP.md](SETUP.md)** - Comprehensive setup guide and troubleshooting

## 🎨 Screenshots

*Screenshots coming soon*

## 🛠️ Development

### Project Structure

```
focuscraft/
├── frontend/              # Flutter application
│   ├── lib/
│   │   ├── domain/        # Domain entities, repositories, use cases
│   │   ├── data/          # Data models, sources, repositories
│   │   ├── presentation/  # BLoC, screens, widgets
│   │   ├── core/          # Error handling, config, utils
│   │   └── graphql/       # Queries, mutations, subscriptions
│   └── pubspec.yaml
│
├── backend/               # Spring Boot application
│   ├── src/main/java/com/focuscraft/
│   │   ├── domain/        # Domain models and repositories
│   │   ├── application/   # Use cases and DTOs
│   │   ├── infrastructure/# JPA, external services
│   │   └── presentation/ # GraphQL resolvers
│   └── pom.xml
│
├── ai-engine/             # Python AI service
│   ├── main.py            # Main AI engine
│   └── requirements.txt
│
└── docker/                # Infrastructure
    └── docker-compose.yml
```

### Contributing

This is a private project. For questions or suggestions, please open an issue.

## 📊 Current Status

- ✅ Core architecture implemented
- ✅ Task management fully functional
- ✅ Analytics dashboard with charts
- ✅ Backend GraphQL API working
- ✅ Data flow end-to-end connected
- 🚧 Habit and Mood screens (UI structure ready)
- 🚧 Weekly planning UI
- 🚧 Voice recording integration
- 🚧 Advanced analytics algorithms

## 🔮 Roadmap

- [ ] Complete Habit and Mood screen implementations
- [ ] Add voice recording and upload functionality
- [ ] Implement weekly plan generation UI
- [ ] Add more analytics visualizations
- [ ] Implement offline-first support
- [ ] Add comprehensive unit tests
- [ ] Performance optimization
- [ ] Production deployment guide
- [ ] Cross-device sync
- [ ] Natural language task creation

## 📄 License

Private project - All rights reserved

## 🙏 Acknowledgments

Built with privacy and user control in mind. All AI models run locally to ensure your data never leaves your infrastructure.

---

<div align="center">

**Made with ❤️ for productivity enthusiasts who value privacy**

[⭐ Star this repo](https://github.com/MohammadSharafi/adaptive-productivity-engine) if you find it useful!

</div>

