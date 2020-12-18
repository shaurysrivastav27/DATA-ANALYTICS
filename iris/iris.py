from sklearn.datasets import load_iris
import pandas as pd
df = pd.read_csv("/home/shaury/Downloads/nptel/Iris.csv",delimiter=",")
#plotting
from plotnine import ggplot,geom_smooth,geom_point,aes
ggplot(df)+geom_point(aes(x=df["Id"],y=df["PetalLengthCm"],color=df["Species"]))
#model knn
from sklearn import neighbors ,preprocessing
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
x,y = df[["SepalLengthCm","SepalWidthCm","PetalLengthCm","PetalWidthCm"]],df["Species"]
x_train,x_test,y_train,y_test=train_test_split(x,y,random_state=0,test_size=0.2)
for i in range(1,20):
    knn =neighbors.KNeighborsClassifier(n_neighbors=i)
    knn.fit(x_train,y_train)
    y_pred= knn.predict(x_test)
    print(accuracy_score(y_test,y_pred))
#selecting the value of k for which we get the maximum accuracy
# k = 7
