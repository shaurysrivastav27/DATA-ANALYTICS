iris= read.csv("/home/shaury/Downloads/nptel/Iris.csv")
> set.seed(123)
> sample = sample.split(iris,SplitRatio=0.8)
> test<-subset(iris,sample==FALSE)
> train <-subset(iris,sample==TRUE)
> library(DMwR)
%%	Loading required package: grid
%%	Registered S3 method overwritten by 'quantmod':
%%  method            from
%%  as.zoo.data.frame zoo 
> nn1 <- kNN(iris$Species~.,train,test,norm=FALSE,k=6)
> table(test[,6],nn1)
%%                 nn1
%%                  Iris-setosa Iris-versicolor Iris-virginica
%%  Iris-setosa              16               0              0
%%  Iris-versicolor           0              17              0
%%  Iris-virginica            0               0             17


