ad = pd.read_csv("/home/shaury/Downloads/nptel/Admission.csv")
ad= ad.dropna()
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score,mean_squared_error

mlr = linear_model.LinearRegression()

x,y = np.array(ad[["GRE_Score","TOEFL_Score","University_Rating","SOP","LOR ","CGPA","Research"]]),np.array(ad["Chance_of_Admit "])
adx_train,adx_test,ady_train,ady_test=train_test_split(x,y,test_size=0.2)

from sklearn.metrics import classification_report as c_r
mlr.fit(adx_train,ady_train)
y_pred = mlr.predict(adx_test)
#print(c_r(ady_test, y_pred))
r2_score(y_pred,ady_test)
