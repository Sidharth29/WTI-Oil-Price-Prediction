# WTI-Oil-Price-Prediction
An R code to build a multilinear regression model(with time lag components) to predict the monthly WTI Oil Prices

Here we aim to build a model to predict the WTI oil prices with a fair deal of accuracy we start off visualizing the response and predictor variables as time series variables and perform a decomposition to analyze their components. We then go on to build a simple Multilinear regression model and evaluate its power of prediction using the model's Rsquared value, Mean squared error(between predicted and actual test set values) and its Mean Absolute Error Value. We observe the ACF plot to pick out the lag components that can be used to improve our model. Based on our observation we go on to include lag components to our model till we stop observing a significant change in the model's Rsquared value and prediction accuracy.

## Data Source 
WTI Oil Prices studied monthly from January 1986 to July 2017 (https://www.eia.gov/)

## Predictors considered
1. United States Petroleum Reserves
2. Treasury Note Rate
3. S&P 500 Index
4. OPEC Crude Oil Production
5. GDP (US)

## Visualization
To understand the components of the response we decompose it and visualize it as a time series variable

<img width="556" alt="y_decomp" src="https://user-images.githubusercontent.com/32235608/37925149-babcc510-30e8-11e8-86b2-9136974c35aa.PNG">

Indivudually observing the correlation between the response and predictors

<img width="674" alt="tn1_fp_decomp" src="https://user-images.githubusercontent.com/32235608/37925446-6f528294-30e9-11e8-9406-02dcffd67517.PNG">
<img width="683" alt="endstock2_sp_decomp" src="https://user-images.githubusercontent.com/32235608/37925500-92f26e80-30e9-11e8-8928-223a787d2a4f.PNG">
<img width="697" alt="gdp3_imports_decomp" src="https://user-images.githubusercontent.com/32235608/37925557-aff0b14a-30e9-11e8-8ba4-ba94967f8dde.PNG">

## Multilinear Regression
A linear regression model is built with the response and predictors
<img width="595" alt="multiregression_code" src="https://user-images.githubusercontent.com/32235608/37926123-59b72438-30eb-11e8-9156-8d2189c8c4f1.PNG">

Summary of the model

<img width="588" alt="multiregression_summary" src="https://user-images.githubusercontent.com/32235608/37926195-8f5fc7c0-30eb-11e8-8e9a-d25687ad65ab.PNG">

Anova of the model

<img width="514" alt="multiregression_anova" src="https://user-images.githubusercontent.com/32235608/37926336-ec6e3d66-30eb-11e8-8e9a-d59f8f7dd5ce.PNG">

## Evaluation: Model 1
The data is divided into training(300/306) and testing sets(6/306) and the training model is used to predict the testset values of
response, the evaluation of the prediction are as follows:

<img width="649" alt="multiregression_predacc" src="https://user-images.githubusercontent.com/32235608/37926664-bdc58478-30ec-11e8-80b0-709d72d8cc52.PNG">

**From the R2 value from the model summary and the prediction accuracy parameters it can be observed that there is scope for
improvement**

## ACF
The Auto Correlation of the response variable is plotted to observe presence of time dependency i.e. if the values in the past[y(n-1), y(n-2).,etc] affect the present[y(n)]

<img width="448" alt="acf" src="https://user-images.githubusercontent.com/32235608/37927044-cee996d0-30ed-11e8-9991-d8ab6575d06f.PNG">

**From the plot we can infer that there is a significant dependance on time lag components which we can leverage to improve our model's
fit and accuracy**

## Model 2 
We add a lag1 [y(n-1)] component to our existing set of predictors and build a new model

Summary of the model

<img width="512" alt="lag1reg_summary" src="https://user-images.githubusercontent.com/32235608/37927658-91178f36-30ef-11e8-834c-08bfe6940dcd.PNG">

Anova of the model

<img width="497" alt="lag1reg_anova" src="https://user-images.githubusercontent.com/32235608/37928077-8a366e34-30f0-11e8-87af-72df50e40cf2.PNG">

**It can be observed that there is an improvement in terms of R2 and adjusted R2 value so we retain lag component and proceed to evaluate the model's prediction accuracy**

## Evaluation - Model 2
We split the data into training and testing sets and perform a prediction using the training model. 

The evaluation of the prediction is as follows:
<img width="638" alt="lag1reg_predacc" src="https://user-images.githubusercontent.com/32235608/37928259-21ba7c64-30f1-11e8-93c0-3e6523cb3220.PNG">

## Model 3
We proceed on the same path and try adding another lag component[y(n-2)] to our predictors and build a new model

Summary of the new model
<img width="505" alt="lag2reg_summary" src="https://user-images.githubusercontent.com/32235608/37928429-a4e073c8-30f1-11e8-8fc8-2ee2fa59eac4.PNG">

Anova of the model
<img width="510" alt="lag2reg_anova" src="https://user-images.githubusercontent.com/32235608/37928455-b3097404-30f1-11e8-9f29-88061035f0c1.PNG">

**An improvement in adjusted R2 value encourages us to retain it, we proceed to evaluate its prediction accuracy**

## Evaluation - Model 3
The evaluation of the model's prediction accuaracy is as follows:

<img width="700" alt="lag2reg_predacc" src="https://user-images.githubusercontent.com/32235608/37928620-38cdb29e-30f2-11e8-984b-13d34f36fcef.PNG">

## Model 4
We try adding another lag component[y(n-3)]

Summary of the model
<img width="500" alt="lag3reg_summary" src="https://user-images.githubusercontent.com/32235608/37928683-9678dfcc-30f2-11e8-9124-6e9c6f4c92ce.PNG">

Anova of the model
<img width="520" alt="lag3reg_anova" src="https://user-images.githubusercontent.com/32235608/37928698-a3f9102c-30f2-11e8-80cb-13710a2bdd1a.PNG">

## Evaluation - Model 4
The evaluation of model's prediction accuracy is presented below:

<img width="758" alt="lag3reg_predacc" src="https://user-images.githubusercontent.com/32235608/37928792-e81312a8-30f2-11e8-930b-810610e9de37.PNG">

**But, on observing the explanatory power of this model we see that there is no significant improvement from the previous model (Lag 2 model) and from the ACF Plot we can infer that the time dependency only goes down with the increase in Lag. So, it is safe to assume that the further addition of time series predictor values with higher Lag are not going to significantly improve the explanatory power nor the prediction accuracy of the model.
So, we conclude our attempt to build a multilinear prediction model with six normal predictor variables and 2-time series predictor variables.**

## Final Model
The final regression model that we obtain out of this iterative improvement process is presented below:
<img width="456" alt="final_model" src="https://user-images.githubusercontent.com/32235608/37928974-7ee3503a-30f3-11e8-958d-4dea56e59773.PNG">

## Possible Improvements
Looking ahead the prediction accuracy can further be improved by using an ensemble model with different components linear, non-linear and time series that can latch on and capture the non-linearity of the actual data. Another improvement that can be made is the variation in the data can be smoothened by conversion into a different domain like logarithmic or squared. A model with good fit can be built by trying to achieve a trade-off between these two methods.







