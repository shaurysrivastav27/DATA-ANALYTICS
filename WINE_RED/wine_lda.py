import pandas as pd
import numpy as np
df = pd.read_csv("/home/shaury/Downloads/nptel/winequality-red.csv")

from plotnine import ggplot , aes , geom_point
ggplot(df)+geom_point(mapping = aes(df["quality"],df["fixed acidity"],color=df["quality"]))

ggplot(df)+geom_point(mapping = aes(df["quality"],df["volatile acidity"],color=df["quality"]))

ggplot(df)+geom_point(mapping = aes(df["citric acid"],df["quality"],color=df["quality"]))

import matplotlib.pyplot as plt
fig, axs = plt.subplots(4,5)
x = df["fixed acidity"]
axs[0, 0].scatter(x,df["volatile acidity"])
axs[0, 0].set_title('volatile')
y = df["citric acid"]
axs[0, 1].scatter(x, y)
axs[0, 1].set_title('citric')
y = df["residual sugar"]
axs[0, 2].scatter(x, y)
axs[0, 2].set_title('residual')
y = df["chlorides"]
axs[0, 3].scatter(x, y)
axs[0, 3].set_title('chlorides')
y = df["free sulfur dioxide"]
axs[0, 4].scatter(x, y)
axs[0, 4].set_title('free suplhur')
y = df["total sulfur dioxide"]
axs[1, 0].scatter(x,y)
axs[1, 0].set_title('total suplhur')
y= df["density"]
axs[1, 1].scatter(x, y)
axs[1, 1].set_title('density')
y= df["pH"]
axs[1, 2].scatter(x, y)
axs[1, 2].set_title('pH')
y= df["sulphates"]
axs[1, 3].scatter(x, y)
axs[1, 3].set_title('sulphates')
y= df["alcohol"]
axs[1, 4].scatter(x, y)
axs[1, 4].set_title('alcohol')
print("volatile now")
import matplotlib.pyplot as plt
fig, axs = plt.subplots(2, 5)
x = df["volatile acidity"]
axs[0, 0].scatter(x,df["fixed acidity"])
axs[0, 0].set_title('fixed')
y = df["citric acid"]
axs[0, 1].scatter(x, y)
axs[0, 1].set_title('citric')
y = df["residual sugar"]
axs[0, 2].scatter(x, y)
axs[0, 2].set_title('residual')
y = df["chlorides"]
axs[0, 3].scatter(x, y)
axs[0, 3].set_title('chlorides')
y = df["free sulfur dioxide"]
axs[0, 4].scatter(x, y)
axs[0, 4].set_title('free suplhur')
y = df["total sulfur dioxide"]
axs[1, 0].scatter(x,y)
axs[1, 0].set_title('total suplhur')
y= df["density"]
axs[1, 1].scatter(x, y)
axs[1, 1].set_title('density')
y= df["pH"]
axs[1, 2].scatter(x, y)
axs[1, 2].set_title('pH')
y= df["sulphates"]
axs[1, 3].scatter(x, y)
axs[1, 3].set_title('sulphates')
y= df["alcohol"]
axs[1, 4].scatter(x, y)
axs[1, 4].set_title('alcohol')

y = df["quality"]
df = df.drop(columns="quality")
x = df

from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size = 0.15)

from sklearn import neighbors
from sklearn.metrics import accuracy_score as ac
from sklearn.metrics import confusion_matrix


from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
lda = LDA(n_components=1)
x_train = lda.fit_transform(x_train,y_train)
x_test = lda.fit_transform(x_test,y_test)
temp,var=0,0
ans = []
from sklearn.ensemble import RandomForestClassifier as RFC
for i in range(1,20):
    cl = RFC(max_depth=i,random_state=0)
    cl.fit(x_train,y_train)
    y_pred = cl.predict(x_test)
    if(temp<ac(y_pred,y_test)):
        temp = ac(y_pred,y_test)
        var = i
        ans = y_pred
print(str(temp)+" "+str(var))
print(confusion_matrix(y_pred,y_test))
