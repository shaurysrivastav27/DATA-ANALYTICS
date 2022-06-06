from transformers import AutoTokenizer, AutoModelForSeq2SeqLM




class EmotionDetection:
    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained("mrm8488/t5-base-finetuned-emotion")
        self.model = AutoModelForSeq2SeqLM.from_pretrained("mrm8488/t5-base-finetuned-emotion")

    def detect_emotion(self, text):
        input_ids = self.tokenizer.encode(text + '</s>', return_tensors='pt')
        output = self.model.generate(input_ids=input_ids, max_length=2)

        dec = [self.tokenizer.decode(ids) for ids in output]
        label = dec[0]
        label = label.replace("<pad>", "")
        return label
