#from DBManager.dbManager import DBManager
from MLCommon.utils import request_body, request_body_wordcloud,Task,Result
from celery.result import AsyncResult
from fastapi.responses import JSONResponse
from celery.utils.log import get_task_logger
from pydantic import BaseModel
import json
from tasks import gender_detect,sentiment_detect,emotion_detect
from fastapi import FastAPI
import os
import sys

file_dir = os.path.dirname(__file__)
sys.path.append(file_dir)

celery_log = get_task_logger(__name__)

app = FastAPI(title="Check ML APIs")
    
@app.get("/health")
async def read_main():
    return {"msg": "works"}


@app.post("/sentimentAnalysis")
def getSentiment(request: request_body):
    print("request recieved at sentiment analysis")
    texts = request.texts
    client_id = request.client_id
    workflow_id = request.workflow_id
    result = []
    for text in texts:
        out = sentiment_detect.delay(text["text"])
        result.append({"id": text["textID"], "result": out})
    ##models.db.update(client_id=client_id, workflowID=workflow_id,model_name='sentiment', results=result)
    celery_log.info(f"Sentiment prediction running!!")
    return {"Status": 200, "model": "sentiment", "results": str(result)}

@app.post("/genderPrediction")
def genderPrediction(request: request_body):
    texts = request.texts
    client_id = request.client_id
    workflow_id = request.workflow_id
    gender_predictions = {}
    for txt in texts:
        gender_predictions[txt["textID"]] = gender_detect.delay(
            txt["user"]["userName"])
    celery_log.info(f"Gender prediction going on!!")
    # update the DB:
    #models.db.update_genders(
    #    client_id=client_id, workflowID=workflow_id, gndr_predictions=gender_predictions)
    return {"Status": 200,"taskID":str(gender_predictions)}
    
@app.post("/emotionDetection")
def emotionDetection(request: request_body):
    texts = request.texts
    client_id = request.client_id
    workflow_id = request.workflow_id
    emotion_dict = {}
    for txt in texts:
        emotion_dict[txt["textID"]] = emotion_detect.delay(txt["text"])
    celery_log.info(f"Emotion prediction going on!!")
    return {"Status": 200,"taskID":str(emotion_dict)}
    
@app.get('/result/{task_id}', response_model=Result, status_code=200,responses={202: {'model': Task, 'description': 'Accepted: Not Ready'}})
async def fetch_result(task_id):
    task = AsyncResult(task_id)
    celery_log.info(f"Getting results!!")
    if not task.ready():
    	celery_log.info(f"Result not ready!!")
    	return JSONResponse(status_code=202, content={'task_id': str(task_id), 'status': 'Processing'})
    result = task.get()
    celery_log.info(f"Result ready!!")
    return {'task_id': task_id, 'status': str(result)}
	

