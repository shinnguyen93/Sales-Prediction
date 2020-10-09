library(aweek)
library(lubridate)
library(tibble)
library(tidyverse)
library(xts)

df<-read.csv("coles_deal.csv", header=TRUE)
colnames(df)[1] <- "Date"

date<-as.Date(df$Date,format="%d/%m/%Y")
value<-as.numeric(df$Dove.Triple.Moisturising.Body.Wash.1L)

doves_data <- xts(value, date)
doves_data

doves<-window(doves_data,start="2020-07-01",end="2020-09-29")
plot(doves)

acf(doves)
pacf(doves)

doves_arima<-arima(doves,order=c(7,0,6))
acf(doves_arima$residuals)
pacf(doves_arima$residuals)

doves_arima

pred_outcome<-predict(doves_arima, n.ahead = 30)


pred_outcome$pred
plot(pred_outcome$pred)
