from transformers import pipeline

class sentimentAnalyser():
    def __init__(self):
        self.model=pipeline('sentiment-analysis')

    def predict(self,text):
        result=self.model(text)
        return result
