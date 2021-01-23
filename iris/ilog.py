import pandas as pd
df = pd.read_csv("/home/shaury/Downloads/nptel/Iris.csv",delimiter=",")
x,y = df[["SepalLengthCm","SepalWidthCm","PetalLengthCm","PetalWidthCm"]],df["Species"]
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.2)
from sklearn.linear_model import LogisticRegression as LR
from sklearn.metrics import classification_report, confusion_matrix
model = LR(solver='liblinear', random_state=0)
model.fit(x_train, y_train)
#model.predict(x_test)
print(confusion_matrix(y_test, model.predict(x_test)))
print(model.intercept_)
print(model.coef_)
from sklearn.metrics import classification_report
print(classification_report(y, model.predict(x)))
