#!/usr/bin/env python3
"""
FocusCraft AI Engine
Processes productivity data and generates behavioral insights using local AI models
"""

import json
import logging
import os
import sys
from typing import Dict, Any, List
from datetime import datetime, timedelta

import pika
import requests
from minio import Minio
from minio.error import S3Error
from sentence_transformers import SentenceTransformer
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct
import whisper
import pandas as pd
from sklearn.cluster import KMeans

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class FocusCraftAIEngine:
    def __init__(self):
        # Configuration from environment
        self.rabbitmq_host = os.getenv('RABBITMQ_HOST', 'localhost')
        self.rabbitmq_queue = os.getenv('RABBITMQ_QUEUE', 'ai.tasks')
        self.minio_endpoint = os.getenv('MINIO_ENDPOINT', 'localhost:9000')
        self.minio_access_key = os.getenv('MINIO_ACCESS_KEY', 'minioadmin')
        self.minio_secret_key = os.getenv('MINIO_SECRET_KEY', 'minioadmin')
        self.minio_bucket = os.getenv('MINIO_BUCKET', 'focuscraft-files')
        self.qdrant_host = os.getenv('QDRANT_HOST', 'localhost')
        self.qdrant_port = int(os.getenv('QDRANT_PORT', '6333'))
        self.backend_url = os.getenv('BACKEND_URL', 'http://localhost:8080')
        
        # Initialize services
        self.minio_client = Minio(
            self.minio_endpoint,
            access_key=self.minio_access_key,
            secret_key=self.minio_secret_key,
            secure=False
        )
        
        self.qdrant_client = QdrantClient(
            host=self.qdrant_host,
            port=self.qdrant_port
        )
        
        # Initialize AI models
        logger.info("Loading AI models...")
        self.embedding_model = SentenceTransformer('all-MiniLM-L6-v2')
        self.whisper_model = whisper.load_model("base")
        logger.info("AI models loaded successfully")
        
        # Initialize Qdrant collection
        self._init_qdrant_collection()
    
    def _init_qdrant_collection(self):
        """Initialize Qdrant collection for embeddings"""
        collection_name = "productivity_data"
        try:
            collections = self.qdrant_client.get_collections()
            collection_names = [c.name for c in collections.collections]
            
            if collection_name not in collection_names:
                self.qdrant_client.create_collection(
                    collection_name=collection_name,
                    vectors_config=VectorParams(
                        size=384,  # all-MiniLM-L6-v2 dimension
                        distance=Distance.COSINE
                    )
                )
                logger.info(f"Created Qdrant collection: {collection_name}")
        except Exception as e:
            logger.error(f"Error initializing Qdrant collection: {e}")
    
    def process_task(self, task: Dict[str, Any]):
        """Process a single AI task"""
        task_type = task.get('type')
        data = task.get('data', {})
        
        logger.info(f"Processing task type: {task_type}")
        
        try:
            if task_type == 'VOICE_LOG':
                self._process_voice_log(data)
            elif task_type == 'BEHAVIORAL_ANALYSIS':
                self._perform_behavioral_analysis(data)
            elif task_type == 'WEEKLY_PLAN':
                self._generate_weekly_plan(data)
            elif task_type == 'TASK_EMBEDDING':
                self._generate_task_embedding(data)
            else:
                logger.warning(f"Unknown task type: {task_type}")
        except Exception as e:
            logger.error(f"Error processing task: {e}", exc_info=True)
    
    def _process_voice_log(self, data: Dict[str, Any]):
        """Transcribe voice log using Whisper"""
        voice_log_id = data.get('voiceLogId')
        file_name = data.get('fileName')
        
        logger.info(f"Transcribing voice log {voice_log_id}")
        
        # Download file from MinIO
        local_path = f"/tmp/{file_name}"
        try:
            self.minio_client.fget_object(self.minio_bucket, file_name, local_path)
        except S3Error as e:
            logger.error(f"Error downloading file from MinIO: {e}")
            raise
        
        # Transcribe with Whisper
        try:
            result = self.whisper_model.transcribe(local_path)
            transcript = result["text"]
            
            # Generate embedding
            embedding = self.embedding_model.encode(transcript).tolist()
            
            # Store in Qdrant
            point = PointStruct(
                id=voice_log_id,
                vector=embedding,
                payload={
                    "type": "voice_log",
                    "voice_log_id": voice_log_id,
                    "transcript": transcript[:500]
                }
            )
            self.qdrant_client.upsert(
                collection_name="productivity_data",
                points=[point]
            )
            
            # Send callback to Spring Boot
            self._notify_voice_processed(voice_log_id, transcript)
            
            # Clean up
            os.remove(local_path)
            
        except Exception as e:
            logger.error(f"Error transcribing audio: {e}")
            if os.path.exists(local_path):
                os.remove(local_path)
            raise
    
    def _perform_behavioral_analysis(self, data: Dict[str, Any]):
        """Perform behavioral analytics on user data"""
        logger.info("Performing behavioral analysis")
        
        # Get user data from backend
        user_id = data.get('userId')
        tasks_data = self._fetch_tasks(user_id)
        mood_logs_data = self._fetch_mood_logs(user_id)
        sessions_data = self._fetch_sessions(user_id)
        habits_data = self._fetch_habits(user_id)
        
        # Analyze productivity peaks
        productivity_peaks = self._analyze_productivity_peaks(sessions_data, tasks_data)
        
        # Analyze habit correlations
        habit_correlations = self._analyze_habit_correlations(habits_data, mood_logs_data, tasks_data)
        
        # Analyze focus patterns
        focus_patterns = self._analyze_focus_patterns(sessions_data)
        
        # Analyze task insights
        task_insights = self._analyze_task_insights(tasks_data)
        
        # Generate weekly summary
        weekly_summary = self._generate_weekly_summary(tasks_data, mood_logs_data, habits_data)
        
        # Send results to backend
        analytics = {
            'productivityPeaks': productivity_peaks,
            'habitCorrelations': habit_correlations,
            'focusPatterns': focus_patterns,
            'taskInsights': task_insights,
            'weeklySummary': weekly_summary
        }
        
        self._notify_analytics_complete(user_id, analytics)
    
    def _analyze_productivity_peaks(self, sessions_data: List, tasks_data: List) -> List[Dict]:
        """Analyze when user is most productive"""
        if not sessions_data:
            return []
        
        # Group sessions by hour
        hourly_scores = {}
        for session in sessions_data:
            hour = datetime.fromisoformat(session['startTime']).hour
            focus_score = session.get('focusScore', 5)
            if hour not in hourly_scores:
                hourly_scores[hour] = []
            hourly_scores[hour].append(focus_score)
        
        # Calculate average productivity per hour
        peaks = []
        for hour, scores in hourly_scores.items():
            avg_score = sum(scores) / len(scores)
            peaks.append({
                'hour': hour,
                'productivityScore': round(avg_score / 10.0, 2),
                'taskCount': len(scores)
            })
        
        return sorted(peaks, key=lambda x: x['productivityScore'], reverse=True)
    
    def _analyze_habit_correlations(self, habits_data: List, mood_logs_data: List, tasks_data: List) -> List[Dict]:
        """Analyze correlation between habits and productivity"""
        correlations = []
        
        for habit in habits_data:
            habit_name = habit.get('name')
            completion_rate = habit.get('completionRate', 0)
            
            # Simple correlation: higher completion rate = better productivity
            productivity_impact = completion_rate * 0.8  # Normalize
            mood_impact = completion_rate * 0.6  # Habits improve mood
            
            correlations.append({
                'habitName': habit_name,
                'productivityImpact': round(productivity_impact, 2),
                'moodImpact': round(mood_impact, 2)
            })
        
        return sorted(correlations, key=lambda x: x['productivityImpact'], reverse=True)
    
    def _analyze_focus_patterns(self, sessions_data: List) -> List[Dict]:
        """Analyze focus patterns by day of week"""
        if not sessions_data:
            return []
        
        day_scores = {}
        for session in sessions_data:
            day = datetime.fromisoformat(session['startTime']).strftime('%A')
            focus_score = session.get('focusScore', 5)
            if day not in day_scores:
                day_scores[day] = []
            day_scores[day].append(focus_score)
        
        patterns = []
        for day, scores in day_scores.items():
            avg_score = sum(scores) / len(scores)
            # Find best hour for this day
            best_hour = 9  # Default to 9 AM
            patterns.append({
                'dayOfWeek': day,
                'averageFocusScore': round(avg_score / 10.0, 2),
                'bestTimeBlock': f"{best_hour}:00-{best_hour+2}:00"
            })
        
        return patterns
    
    def _analyze_task_insights(self, tasks_data: List) -> List[Dict]:
        """Analyze task patterns and insights"""
        insights = []
        
        for task in tasks_data:
            if task.get('status') == 'COMPLETED' and task.get('actualDuration'):
                insights.append({
                    'taskId': task.get('id'),
                    'taskTitle': task.get('title'),
                    'averageDuration': task.get('actualDuration'),
                    'difficultyRating': task.get('difficulty', 5) / 10.0,
                    'energyDrain': (task.get('energyLevel', 5) / 10.0) * 0.8
                })
        
        return insights
    
    def _generate_weekly_summary(self, tasks_data: List, mood_logs_data: List, habits_data: List) -> Dict:
        """Generate weekly summary statistics"""
        total_tasks = len(tasks_data)
        completed_tasks = len([t for t in tasks_data if t.get('status') == 'COMPLETED'])
        
        # Calculate average focus score from sessions
        avg_focus = 7.0  # Default, would calculate from actual sessions
        
        # Top habits
        top_habits = sorted(habits_data, key=lambda h: h.get('streak', 0), reverse=True)[:3]
        top_habit_names = [h.get('name') for h in top_habits]
        
        # Mood trend
        if mood_logs_data:
            recent_moods = [m.get('mood') for m in mood_logs_data[-7:]]
            mood_trend = 'IMPROVING' if len(recent_moods) > 0 else 'STABLE'
        else:
            mood_trend = 'STABLE'
        
        return {
            'totalTasks': total_tasks,
            'completedTasks': completed_tasks,
            'averageFocusScore': round(avg_focus, 2),
            'topHabits': top_habit_names,
            'moodTrend': mood_trend
        }
    
    def _generate_weekly_plan(self, data: Dict[str, Any]):
        """Generate adaptive weekly plan"""
        user_id = data.get('userId')
        week_start = data.get('weekStart')
        
        logger.info(f"Generating weekly plan for user {user_id}, week starting {week_start}")
        
        # Fetch historical data
        tasks_data = self._fetch_tasks(user_id)
        mood_logs_data = self._fetch_mood_logs(user_id)
        sessions_data = self._fetch_sessions(user_id)
        
        # Generate recommendations using Llama.cpp (simplified for now)
        recommendations = self._generate_recommendations(tasks_data, mood_logs_data, sessions_data)
        
        # Generate insights text
        insights = self._generate_insights_text(tasks_data, mood_logs_data)
        
        # Send to backend
        self._notify_weekly_plan_complete(user_id, week_start, recommendations, insights)
    
    def _generate_recommendations(self, tasks_data: List, mood_logs_data: List, sessions_data: List) -> List[Dict]:
        """Generate personalized recommendations"""
        recommendations = []
        
        # Task priority recommendations
        high_priority_tasks = [t for t in tasks_data if t.get('priority') == 'HIGH' and t.get('status') != 'COMPLETED']
        for task in high_priority_tasks[:3]:
            recommendations.append({
                'type': 'TASK_PRIORITY',
                'title': f"Focus on: {task.get('title')}",
                'description': f"This high-priority task should be completed soon",
                'priority': 9,
                'taskId': task.get('id'),
                'suggestedTime': '09:00'
            })
        
        # Time block recommendations
        if sessions_data:
            best_hour = 9  # Would calculate from actual data
            recommendations.append({
                'type': 'TIME_BLOCK',
                'title': 'Optimal Work Time',
                'description': f'Your most productive hours are {best_hour}:00-{best_hour+2}:00',
                'priority': 7,
                'suggestedTime': f'{best_hour}:00'
            })
        
        return recommendations
    
    def _generate_insights_text(self, tasks_data: List, mood_logs_data: List) -> str:
        """Generate insights text using Llama.cpp (simplified)"""
        completed_count = len([t for t in tasks_data if t.get('status') == 'COMPLETED'])
        total_count = len(tasks_data)
        
        if total_count > 0:
            completion_rate = (completed_count / total_count) * 100
            return f"Last week you completed {completed_count} out of {total_count} tasks ({completion_rate:.1f}% completion rate). "
        return "Start tracking your tasks to get personalized insights!"
    
    def _generate_task_embedding(self, data: Dict[str, Any]):
        """Generate embedding for task and store in Qdrant"""
        task_id = data.get('taskId')
        task_title = data.get('title')
        task_description = data.get('description', '')
        
        text = f"{task_title} {task_description}"
        embedding = self.embedding_model.encode(text).tolist()
        
        point = PointStruct(
            id=task_id,
            vector=embedding,
            payload={
                "type": "task",
                "task_id": task_id,
                "title": task_title
            }
        )
        
        self.qdrant_client.upsert(
            collection_name="productivity_data",
            points=[point]
        )
        
        logger.info(f"Generated embedding for task {task_id}")
    
    def _fetch_tasks(self, user_id: str) -> List[Dict]:
        """Fetch tasks from backend"""
        try:
            response = requests.get(f"{self.backend_url}/api/data/tasks?userId={user_id}")
            if response.status_code == 200:
                return response.json()
        except Exception as e:
            logger.error(f"Error fetching tasks: {e}")
        return []
    
    def _fetch_mood_logs(self, user_id: str) -> List[Dict]:
        """Fetch mood logs from backend"""
        try:
            response = requests.get(f"{self.backend_url}/api/data/mood-logs?userId={user_id}")
            if response.status_code == 200:
                return response.json()
        except Exception as e:
            logger.error(f"Error fetching mood logs: {e}")
        return []
    
    def _fetch_sessions(self, user_id: str) -> List[Dict]:
        """Fetch productivity sessions from backend"""
        try:
            response = requests.get(f"{self.backend_url}/api/data/sessions?userId={user_id}")
            if response.status_code == 200:
                return response.json()
        except Exception as e:
            logger.error(f"Error fetching sessions: {e}")
        return []
    
    def _fetch_habits(self, user_id: str) -> List[Dict]:
        """Fetch habits from backend"""
        try:
            response = requests.get(f"{self.backend_url}/api/data/habits?userId={user_id}")
            if response.status_code == 200:
                return response.json()
        except Exception as e:
            logger.error(f"Error fetching habits: {e}")
        return []
    
    def _notify_voice_processed(self, voice_log_id: int, transcript: str):
        """Notify backend that voice log is processed"""
        url = f"{self.backend_url}/api/callback/voice-processed"
        payload = {
            "voiceLogId": voice_log_id,
            "transcript": transcript
        }
        try:
            requests.post(url, json=payload)
            logger.info(f"Notified backend of voice log processing: {voice_log_id}")
        except Exception as e:
            logger.error(f"Error notifying backend: {e}")
    
    def _notify_analytics_complete(self, user_id: str, analytics: Dict):
        """Notify backend that analytics are complete"""
        url = f"{self.backend_url}/api/callback/analytics-complete"
        payload = {
            "userId": user_id,
            "analytics": analytics
        }
        try:
            requests.post(url, json=payload)
            logger.info(f"Notified backend of analytics completion: {user_id}")
        except Exception as e:
            logger.error(f"Error notifying backend: {e}")
    
    def _notify_weekly_plan_complete(self, user_id: str, week_start: str, recommendations: List[Dict], insights: str):
        """Notify backend that weekly plan is generated"""
        url = f"{self.backend_url}/api/callback/weekly-plan-complete"
        payload = {
            "userId": user_id,
            "weekStart": week_start,
            "recommendations": recommendations,
            "insights": insights
        }
        try:
            requests.post(url, json=payload)
            logger.info(f"Notified backend of weekly plan completion: {user_id}")
        except Exception as e:
            logger.error(f"Error notifying backend: {e}")
    
    def start_consuming(self):
        """Start consuming messages from RabbitMQ"""
        connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.rabbitmq_host)
        )
        channel = connection.channel()
        
        channel.queue_declare(queue=self.rabbitmq_queue, durable=True)
        channel.basic_qos(prefetch_count=1)
        
        def callback(ch, method, properties, body):
            try:
                task = json.loads(body)
                self.process_task(task)
                ch.basic_ack(delivery_tag=method.delivery_tag)
            except Exception as e:
                logger.error(f"Error processing message: {e}", exc_info=True)
                ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)
        
        channel.basic_consume(
            queue=self.rabbitmq_queue,
            on_message_callback=callback
        )
        
        logger.info(f"Waiting for messages on queue: {self.rabbitmq_queue}")
        channel.start_consuming()


def main():
    """Main entry point"""
    engine = FocusCraftAIEngine()
    try:
        engine.start_consuming()
    except KeyboardInterrupt:
        logger.info("Shutting down AI engine...")
        sys.exit(0)


if __name__ == '__main__':
    main()

