## This is an sample API code for testing of the APIs built.

### For installing the dependencies : 
```
cd sample-app
pip install -r requirement.txt
```

### To start the fastapi server : 
```
uvicorn Main:app --reload
``` 

### To start celery server : 
```
celery -A worker worker --pool=solo --loglevel=INFO
```

Now visit the link to test the models: 
```
http://127.0.0.1:8000/docs#/
```
