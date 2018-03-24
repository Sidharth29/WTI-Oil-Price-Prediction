# WTI-Oil-Price-Prediction
An R code to build a multilinear regression model(with time lag components) to predict the monthly WTI Oil Prices

Here we aim to build a model to predict the WTI oil prices with a fair deal of accuracy we start off visualizing the response and predictor variables as time series variables and perform a decomposition to analyze their components. We then go on to build a simple Multilinear regression model and evaluate its power of prediction using the model's Rsquared value, Mean squared error(between predicted and actual test set values) and its Mean Absolute Error Value. We observe the ACF plot to pick out the lag components that can be used to improve our model. Based on our observation we go on to include lag components to our model till we stop observing a significant change in the model's Rsquared value and prediction accuracy.

## Data Source 
WTI Oil Prices studied monthly from January 1986 to July 2017 (https://www.eia.gov/)

## Predictors considered
1.United States Petroleum Reserves:
2.Treasury Note Rate
3.S&P 500 Index
4.OPEC Crude Oil Production
5.GDP (US)
