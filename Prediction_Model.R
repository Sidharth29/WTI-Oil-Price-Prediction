# Uploading the data - Std_WTI.csv
d=read.csv(file.choose(),header=T)
names(d)
d

# Visualization of response(WTI Spot Price)
ts_sp<-ts(d$Spot.Price,start=c(1992,3),frequency = 12)
plot(ts_sp)
abline(lm(ts_sp~time(ts_sp)))
d_sp<-decompose(ts_sp)
plot(d_sp)
##The decomposition of the data shows that the data has both 
# seasonal and non seasonal components hence it cannot be 
# characterized by a pure time series model alone, hence we use
# the help of predictor variables to explain the model

# Juxtaposed visualization of the response and predictors
##Imports and Spot Price
ts_imp<-ts(d$Imports,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_imp,col=c('red','blue'))
##Field Production and Spot Price
ts_fp<-ts(d$Field_Prod,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_fp,col=c('red','blue'))
##GDP and Spot Price
ts_gdp<-ts(d$GDP,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_gdp,col=c('red','blue'))
##S&P500 and Spot Price
ts_s500<-ts(d$SP500,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_s500,col=c('red','blue'))
##Petrol Reserves End Stocks and Spot Price
ts_spr<-ts(d$EndStocks,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_spr,col=c('red','blue'))
##Treasury Note value and Spot Price
ts_tn<-ts(d$Tnote,start=c(1992,3),frequency = 12)
ts.plot(ts_sp,ts_tn,col=c('red','blue'))
# From the above visulaizations it can roughly be seen that 
# there is a possibility to capture some of the randomness in 
# the spot price by using these values as predictors

# Multilinear regression with Spot Price as response and the 
# combination of Imports, Field Production, GDP, S&P500, SPR stock
# rates and Treasury note values as predictors
Oil<- read.delim(file.choose(),header=TRUE, sep=",") #Reg_Data.csv
Oil
OIL_NEW= lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note, data=Oil)
summary(OIL_NEW)
anova(OIL_NEW)
## We observe that all predictors apart from the Treasury Note
## values turn out to be significant

## Splitting of data into training and testing sets
train<-tail(Oil,300)
test<-head(Oil,6)
model_fit<-lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note, data= train)
summary(model_fit)

##Prediction using the training model
predictest<-predict(model_fit, test)
predictest

##Gauging prediction accuracy
actuals_preds <- data.frame(cbind(actuals=test$Oil_Price, predicteds=predictest))  # make actuals_predicteds dataframe.
correlation_accuracy <- cor(actuals_preds)
correlation_accuracy
head(actuals_preds)

min_max_accuracy <- abs(mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))) 
min_max_accuracy
mape <- abs(mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals))
mape
me <- mean(abs(actuals_preds$predicteds - actuals_preds$actuals))
me
mae <- mean(abs(actuals_preds$predicted- mean(actuals_preds$actuals)))
mae

#Autocorrelation plot of the spotprice values
acf(ts_sp)

## We observe there seems to be a dependance on lag terms,
## hence model with lag elements can improve the explanatory
## power as well as the prediction accuracy

#Building a new model with 1time series element with lag=1
Oil_1 <- read.delim(file.choose(),header=TRUE, sep=",") #Reg_Data_Lag1
Oil_1
OIL_NEW_1= lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note+Y_n_1, data=Oil_1)
summary(OIL_NEW_1)
anova(OIL_NEW_1)

##Training and Testing
train_1<-tail(Oil_1,300)
test_1<-head(Oil_1,6)
model_fit_1<-lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note, data= train_1)
summary(model_fit_1)

##Prediction
predictest_1<-predict(model_fit_1, test_1)
predictest_1

##Gauging Prediction accuracy
actuals_preds_1 <- data.frame(cbind(actuals=test_1$Oil_Price, predicteds=predictest_1))  # make actuals_predicteds dataframe.
correlation_accuracy_1 <- cor(actuals_preds_1)
correlation_accuracy_1
head(actuals_preds_1)

min_max_accuracy_1 <- abs(mean(apply(actuals_preds_1, 1, min) / apply(actuals_preds_1, 1, max))) 
min_max_accuracy_1
mape_1 <- abs(mean(abs((actuals_preds_1$predicteds - actuals_preds_1$actuals))/actuals_preds_1$actuals))
mape_1
me_1<- mean(abs(actuals_preds_1$predicteds - actuals_preds_1$actuals))
me_1
mae_1 <- mean(abs(actuals_preds_1$predicted- mean(actuals_preds_1$actuals)))
mae_1

# Attempting further improvement with another time series 
# component with lag=2
Oil_2 <- read.delim(file.choose(),header=TRUE, sep=",") #Reg_Data_Lag2
Oil_2
OIL_NEW_2= lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note+Y_n_1+Y_n_2, data=Oil_2)
summary(OIL_NEW_2)
anova(OIL_NEW_2)
##Training and Testing
train_2<-tail(Oil_2,300)
test_2<-head(Oil_2,5)
model_fit_2<-lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note, data= train_2)
summary(model_fit_2)
##Prediction
predictest_2<-predict(model_fit_2, test_2)
predictest_2
##Gauging Prediction accuracy
actuals_preds_2 <- data.frame(cbind(actuals=test_2$Oil_Price, predicteds=predictest_2))  # make actuals_predicteds dataframe.
correlation_accuracy_2 <- cor(actuals_preds_2)
correlation_accuracy_2
head(actuals_preds_2)

min_max_accuracy_2 <- abs(mean(apply(actuals_preds_2, 1, min) / apply(actuals_preds_2, 1, max))) 
min_max_accuracy_2
mape_2 <- abs(mean(abs((actuals_preds_2$predicteds - actuals_preds_2$actuals))/actuals_preds_2$actuals))
mape_2
me_2<- mean(abs(actuals_preds_2$predicteds - actuals_preds_2$actuals))
me_2
mae_2 <- mean(abs(actuals_preds_2$predicted- mean(actuals_preds_2$actuals)))
mae_2

##Including another time series element with lag=3
Oil_3 <- read.delim(file.choose(),header=TRUE, sep=",") #Reg_Data_Lag3
Oil_3
OIL_NEW_3= lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note+Y_n_1+Y_n_2+Y_n_3, data=Oil_3)
summary(OIL_NEW_3)
anova(OIL_NEW_3)

##Training and Testing
train_3<-tail(Oil_3,300)
test_3<-head(Oil_3,5)
model_fit_3<-lm(Oil_Price~Imports+Production+GDP+SP500+Stock_value+Treasury_note, data= train_3)
summary(model_fit_3)
predictest_3<-predict(model_fit_3, test_3)
predictest_3

##Gauging prediction accuracy
actuals_preds_3 <- data.frame(cbind(actuals=test_3$Oil_Price, predicteds=predictest_3))  # make actuals_predicteds dataframe.
correlation_accuracy_3 <- cor(actuals_preds_3)
correlation_accuracy_3
head(actuals_preds_3)

min_max_accuracy_3 <- abs(mean(apply(actuals_preds_3, 1, min) / apply(actuals_preds_3, 1, max))) 
min_max_accuracy_3
mape_3 <- abs(mean(abs((actuals_preds_3$predicteds - actuals_preds_3$actuals))/actuals_preds_3$actuals))
mape_3
me_3<- mean(abs(actuals_preds_3$predicteds - actuals_preds_3$actuals))
me_3
mae_3 <- mean(abs(actuals_preds_3$predicted- mean(actuals_preds_3$actuals)))
mae_3

##From the adjusted R^2 value we observe that there is not much
##improvement in the explanatory power of the model compared to the
##previous one and change in the prediction accuracy of the model 
##is not significantly high. The correlation on lag elements
##progressively decreses so we decide to stop including new time 
##series terms and settle with the lag2 model

###Final Prediction Model
# || Y = -3.174e-10 - 2.827e-02 Imp - 4.796e-02 FProd + 
#      5.367e-02 GDP - 2.974e-03 SP500 + 3.452e-02 SPR + 
#      8.035e-03 TN + 1.323e+00 Yn-1 - 3.969e-01 yn-2 ||








