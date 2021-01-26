import pandas as pd
df= pd.read_csv("/home/shaury/Downloads/nptel/winequality-red.csv",delimiter = ",")

from plotnine import ggplot,geom_point,aes
ggplot(df)+geom_point(mapping= aes(x = df["fixed acidity"],y=df["sulphates"],color=df["quality"]))

from sklearn.model_selection import train_test_split
x,y = df[["fixed acidity","volatile acidity","citric acid","residual sugar","chlorides","free sulfur dioxide","total sulfur dioxide","density","pH","sulphates","alcohol"]],df["quality"]
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.15)

from sklearn.linear_model import LogisticRegression as LR
ld = LR(solver='liblinear', random_state=0)
ld.fit(x_train,y_train)
y_pred = ld.predict(x_test)

from sklearn.metrics import accuracy_score,confusion_matrix
print(accuracy_score(y_pred,y_test))

print(confusion_matrix(y_pred,y_test))
