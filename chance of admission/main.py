ad = pd.read_csv("/home/shaury/Downloads/nptel/Admission.csv")
ad= ad.dropna()
import numpy as np
ad1=np.array(ad)
import matplotlib.pyplot as plt
for i in range(1, 7):
    plt.subplot(2, 3, i)
    plt.scatter(ad1[:,7],ad1[:,i-1])
    plt.title(i-1)
plt.show()
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score,mean_squared_error

mlr = linear_model.LinearRegression()

x,y = np.array(ad[["GRE_Score","TOEFL_Score","University_Rating","CGPA","Research"]]),np.array(ad["Chance_of_Admit "])
adx_train,adx_test,ady_train,ady_test=train_test_split(x,y,test_size=0.2)


from sklearn.metrics import classification_report as c_r
mlr.fit(adx_train,ady_train)
y_pred = mlr.predict(adx_test)
#print(c_r(ady_test, y_pred))
r2_score(y_pred,ady_test)
