import tensorflow as tf
import string
import numpy as np
import re


class gender_classifier:
    def __init__(self):
        self.model = tf.keras.models.load_model(
            './genderPrediction/gender_classifier.h5')
        self.map_gender = {0: "M", 1: "F"}
        self.map_letter = dict(
            zip(list(string.ascii_lowercase), np.arange(0, 26)))

    def map_letter_func(self, s):
        return np.array([self.map_letter[i] for i in s.lower().strip()])

    def predict_gender(self, name):
        name = re.subn("[^A-Za-z]", "", name)[0]
        x = self.map_letter_func(name)
        x = tf.keras.preprocessing.sequence.pad_sequences([x], maxlen=15)
        return self.map_gender[np.argmax(self.model.predict(x.reshape(-1, 1, 15)))]
