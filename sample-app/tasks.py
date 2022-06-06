from worker import app
from celery.utils.log import get_task_logger
from genderPrediction.genderclassifier import gender_classifier
from sentimentAnalysis.sentimentAnalyser import sentimentAnalyser
from emotion.emotionDetection import EmotionDetection
import time
celery_log = get_task_logger(__name__)
class models:
	def __init__(self):
		self.emotion_model = EmotionDetection()
		self.gendermodel = gender_classifier()
		self.sentimentmodel = sentimentAnalyser()

model = models()

@app.task(name='genderclassifier')
def gender_detect(name):
	celery_log.info(f"Gender detection Function called !")
	gender = model.gendermodel.predict_gender(name)
	final = f"The gender of {name} is {gender}"
	celery_log.info(f"Celery task completed!")
	return final
    
@app.task(name='sentiment')
def sentiment_detect(text):
	celery_log.info(f"Sentiment detection function called !")
	sentiment = model.sentimentmodel.predict(text)
	return sentiment[0]['label']

@app.task(name='emotion')
def emotion_detect(text):
	celery_log.info(f"Emotion detection function Called !")
	emotion = model.emotion_model.detect_emotion(text)
	return emotion

