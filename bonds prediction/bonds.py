bond = pd.read_csv("/home/shaury/Downloads/nptel/bonds.csv",delimiter=",")
bond=bond.dropna()
from plotnine import ggplot,geom_point,aes,geom_smooth
ggplot(bond)+geom_point(mapping=aes(x=bond["CouponRate"],y=bond["BidPrice"]))
from sklearn import linear_model
from sklearn.metrics import mean_squared_error,r2_score
from sklearn.model_selection import train_test_split
rgr = linear_model.LinearRegression()
x,y = np.array(bond["CouponRate"]),np.array(bond["BidPrice"])
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2)
x_train=x_train.reshape(-1,1)
y_train=y_train.reshape(-1,1)
#print(x_train,y_train)
rgr.fit(x_train,y_train)
x_test= x_test.reshape(-1,1)
y_pred = rgr.predict(x_test)
y_test=y_test.reshape(-1,1)
print("mean squared error: ",mean_squared_error(y_test,y_pred)
print("R^2 value :",r2_score(y_test,y_pred))
import matplotlib.pyplot as plt
plt.scatter(x_test,y_test)
plt.plot(x_test,y_pred)
plt.show()
