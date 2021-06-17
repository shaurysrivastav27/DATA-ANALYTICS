import pandas as pd
import numpy as np
df = pd.read_csv("/home/shaury/Downloads/nptel/Iris.csv",delimiter=",")
x,y = df[["SepalLengthCm","SepalWidthCm","PetalLengthCm","PetalWidthCm"]],df["Species"]
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y,random_state = 1, test_size=0.15)


from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as lda
l1 = lda(n_components=1)
x_train = l1.fit_transform(x_train,y_train)
x_test = l1.fit_transform(x_test,y_test)

from sklearn.ensemble import RandomForestClassifier as RFC
cl = RFC(max_depth=2,random_state=0)
cl.fit(x_train,y_train)
y_pred = cl.predict(x_test)

from sklearn.metrics import confusion_matrix,accuracy_score
cm = confusion_matrix(y_test, y_pred)
print(cm)
print('Accuracy' + str(accuracy_score(y_test, y_pred)))

