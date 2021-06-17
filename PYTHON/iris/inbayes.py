import pandas as pd
import numpy as np
df = pd.read_csv("/home/shaury/Downloads/nptel/Iris.csv")
from sklearn.model_selection import train_test_split
x,y= df[["SepalLengthCm" ,"SepalWidthCm" ,"PetalLengthCm" ,"PetalWidthCm"]],df["Species"]
x_train,x_test,y_train,y_test= train_test_split(x,y,test_size = 0.2)
from sklearn.naive_bayes import GaussianNB
gnb = GaussianNB()
gnb1 = gnb.fit(x_train,y_train)
y_pred= gnb1.predict(x_test)
from sklearn.metrics import confusion_matrix
print(confusion_matrix(y_pred,y_test))
