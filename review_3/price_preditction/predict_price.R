library(quantmod);
library(tseries);
library(timeSeries);
library(forecast)
library(xts);
library(anytime);

data <-  read.csv("sbi.csv")
#data_x <- xts(data, order.by = as.Date(rownames(data), "%d-%MM-%Y"))

stock_prices <- data$Close.Price
stock = diff(log(stock_prices),lag=1)
stock

stock = stock[!is.na(stock)]
stock
# Plot log returns anyda
dev.copy(png, "log_returns.png")
plot(stock,type='l', main='log returns plot')
dev.off()

print(adf.test(stock))
stock = as.matrix(stock)
breakpoint = floor(nrow(as.matrix(stock))*(2.9/3))
breakpoint
par(mfrow = c(1,1))

dev.copy(png, "acf.png")
acf.stock = acf(stock[c(1:breakpoint),], main='ACF Plot', lag.max=100)
dev.off()
dev.copy(png, "pacf.png")
pacf.stock = pacf(stock[c(1:breakpoint),], main='PACF Plot', lag.max=100)
dev.off()

# Initialzing an xts object for Actual log returns
Actual_series = xts(0,anydate("01-March-2016"))
print(Actual_series)
# Initialzing a dataframe for the forecasted return series
forecasted_series = data.frame(Forecasted = numeric())

for (b in breakpoint:(nrow(stock)-1)) {
  
  stock_train = stock[1:b, ]
  stock_test = stock[(b+1):nrow(stock), ]
  
  # Summary of the ARIMA model using the determined (p,d,q) parameters
  fit = arima(stock_train, order = c(2, 0, 2),include.mean=FALSE)
  summary(fit)
  
  dev.copy(png, "residuals.png")
  # plotting a acf plot of the residuals
  acf(fit$residuals,main="Residuals plot")
  dev.off()
  
  # Forecasting the log returns
  arima.forecast = forecast.Arima(fit, h = 1,level=99)
  summary(arima.forecast)
  
  # plotting the forecast
  par(mfrow=c(1,1))
  dev.copy(png, "forecast.png")
  plot(arima.forecast, main = "ARIMA Forecast")
  dev.off()
  
  # Creating a series of forecasted returns for the forecasted period
  forecasted_series = rbind(forecasted_series,arima.forecast$mean[1])
  colnames(forecasted_series) = c("Forecasted")
  
  # Creating a series of actual returns for the forecasted period
  Actual_return = as.matrix(stock[(b+1),])
  #print(b+1)
  #print("nrows")
  #print(nrow(Actual_return))
  Actual_series = c(Actual_series,xts(Actual_return, anydate(data$Date[b+1])))
  rm(Actual_return)
  
  #print("actual return")
  print(stock_prices[(b+1)])
  print(stock_prices[(b+2)])
  
  
}

Actual_series = Actual_series[-1]

# Create a time series object of the forecasted series
forecasted_series = xts(forecasted_series,index(Actual_series))
print(nrow(forecasted_series))
print(forecasted_series)
# Create a plot of the two return series - Actual versus Forecasted
plot(Actual_series,type='l',main='Actual Returns Vs Forecasted Returns')
lines(forecasted_series,lwd=1.5,col='red')
legend('bottomright',c("Actual","Forecasted"),lty=c(1,1),lwd=c(1.5,1.5),col=c('black','red'))

# Create a table for the accuracy of the forecast
comparsion = merge(Actual_series,forecasted_series)
comparsion$Accuracy = sign(comparsion$Actual_series)==sign(comparsion$Forecasted)
print(comparsion)

# Compute the accuracy percentage metric
Accuracy_percentage = sum(comparsion$Accuracy == 1)*100/length(comparsion$Accuracy)
print(Accuracy_percentage)
