import pandas as pd
salary = pd.read_csv("/home/shaury/Downloads/nptel/Salary.csv")
salary

from plotnine import geom_point,aes,ggplot,geom_smooth
ggplot(data=salary,mapping = aes(x = salary["Years_of_exp"],y=salary["Salary"]))+geom_point()+geom_smooth()

from sklearn.model_selection import train_test_split
import numpy as np
x = salary["Years_of_exp"]
y = salary["Salary"]
x_train,x_test,y_train,y_test = train_test_split(x,y,test_size=0.15)
#
x_train = np.array(x_train)
y_train = np.array(y_train)
x_test = np.array(x_test)
x_train = x_train.reshape(-1,1)
y_train = y_train.reshape(-1,1)
x_test = x_test.reshape(-1,1)

from sklearn.linear_model import LinearRegression as lr
from sklearn.metrics import r2_score
LR= lr()
LR.fit(x_train,y_train)
y_pred = LR.predict(x_test)
r2_score(y_pred,y_test)
