import pandas as pd
titanic = pd.read_csv("/home/shaury/Downloads/nptel/titanic/train.csv",delimiter=",")
test = pd.read_csv("/home/shaury/Downloads/nptel/titanic/test.csv")

from plotnine import ggplot,aes,geom_bar
t = titanic[titanic["Survived"]==1]
ggplot(t, aes(t["Pclass"], fill=t["Sex"]))+geom_bar()

t = titanic[titanic["Survived"]==0]
ggplot(t, aes(t["Pclass"], fill=t["Sex"]))+geom_bar()

t = titanic[titanic["Survived"]==1]
ggplot(t, aes(t["Pclass"], fill=t["Survived"]))+geom_bar()

t = titanic[titanic["Survived"]==0]
ggplot(t, aes(t["Pclass"], fill=t["Survived"]))+geom_bar()
o = titanic["Sex"]
p = test["Sex"]
l = []
for i in range(0,len(titanic)):
    if(o[i]=="female"):
        l.append(1)
    else: 
        l.append(0)
l = pd.DataFrame(l)
l = pd.concat([l,titanic["Pclass"]],join = 'outer', axis = 1)
l

l1 = []
for i in range(0,len(test)):
    if(p[i]=="female"):
        l1.append(1)
    else: 
        l1.append(0)
l1 = pd.DataFrame(l1)
l1 = pd.concat([l1,test["Pclass"]],join = 'outer', axis = 1)
l1

x = l
y = titanic["Survived"]
x_test = l1

#lda analysis
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from sklearn.ensemble import RandomForestClassifier as RFC
from sklearn.metrics import accuracy_score,confusion_matrix
ldatemp,rfcdepth,acc=0,0,0
var = []
for i in range(1,2):
    lda = LDA(n_components=i)
    x=lda.fit_transform(x,y)
    x_test=lda.transform(x_test)
    for j in range(1,20):
        cl= RFC(max_depth=j,random_state=0)
        cl.fit(x,y)
        y_pred = cl.predict(x)
        if(acc<accuracy_score(y_pred,y)):
            acc = accuracy_score(y_pred,y)
            ldatemp=i
            rfcdepth=j
            var = y_pred
print(confusion_matrix(var,titanic["Survived"]))
print(str(rfcdepth)+" "+str(ldatemp)+" "+str(acc))
lda = LDA(n_components=ldatemp)
x = lda.fit_transform(x,y)
x_test = lda.transform(x_test)
cl= RFC(max_depth=rfcdepth,random_state=0)
cl.fit(x,y)
y_pred = cl.predict(x_test)
print(y_pred)
