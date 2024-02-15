#### Preamble ####
# Purpose: Simulates energy prices and consumption in Japan from 2005 to 2015.
# Date: 14 February 2024
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(123) # For reproducibility 

n <- 11 # Number of years in the figure from 2005 to 2015

years_price <- rep(NA, times=n)
years_consumption <- rep(NA, times=n)

# Percent of energy price from 2005 to 2007
# Should be 0.9-1% for all years
for (i in 1:3) {
  years_price[i] <- (sample(9:10, 1))/10
}

# Percent of energy price in 2008
# Should be 1-1.05%
years_price[4] <-(sample(100:105, 1))/100

# Percent of energy price from 2009 to 2010
# Should be 0.9-1% for both years
for (i in 5:6) {
  years_price[i] <- (sample(9:10, 1))/10
}

# Percent of energy price from 2011 to 2015
# Should be increasing from around 1% to under 1.2%
increase <- 0
for (i in 7:n) {
  years_price[i] <- 1 + increase
  increase = increase + 0.05
}

# Percent of energy consumption from 2005 to 2008
# Should be increasing from around 1% to under 1.1%
increase <- 0
for (i in 1:4) {
  years_consumption[i] <- 1 + increase
  increase = increase + 0.03
}

# Percent of energy consumption in 2009
# Should be 0.7-1%
years_consumption[5] <- (sample(7:10, 1))/10

# Percent of energy consumption from 2010 to 2015
# Should be decreasing from around 1.05% to close to 0%
decrease <- 0
for (i in 6:n) {
  years_consumption[i] <- 1.05 - decrease
  decrease = decrease + 0.05
}

simulated_data <-
  tibble(
    year = 2005:2015,
    price = years_price,
    consumption = years_consumption
  )

ggplot(simulated_data, aes(x=year)) +
  geom_line(aes(y = years_price), color="blue") +
  geom_line(aes(y = years_consumption), color="red") +
  geom_point(aes(y = years_price), color="blue") +
  geom_point(aes(y = years_consumption), color="red") +
  theme_fivethirtyeight() +
  theme_bw() +
  labs(title = "Relative Energy Price and Consumption", 
       x = "Year", y = "Relative Price/Consumption")


#### Test data ####

# Checking that there are only 11 years involved from 2005 to 2015
simulated_data$year |> length() == 11
  
# Checking that the only years involved are from 2005 to 2015 in that order
simulated_data$year == c(2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 
                           2014, 2015)

# Checking the classes of the columns
simulated_data$year |> class() == "integer"
simulated_data$price |> class() == "numeric"
simulated_data$consumption |> class() == "numeric"

# Checking that the percent of energy price for all years is between 
# 0.9% and 1.2%
between(simulated_data$price, 0.9, 1.2)

# Checking that the percent of energy consumption for all years is between 
# 0% and 1.1%
between(simulated_data$consumption, 0, 1.1)

# Checking that the percent of energy price from 2005 to 2007 is between 0.9% 
# and 1%
between(simulated_data$price[1:3], 0.9, 1)

# Checking that the percent of energy price in 2008 is between 1% 
# and 1.05%
between(simulated_data$price[4], 1, 1.05)

# Checking that the percent of energy price from 2009 to 2010 is between 0.9% 
# and 1%
between(simulated_data$price[5:6], 0.9, 1)

# Checking that the percent of energy price from 2011 to 2015 is between 1% 
# and 1.2%
between(simulated_data$price[7:11], 1, 1.2)

# Checking that the percent of energy consumption from 2005 to 2008 is between
# 1% and 1.1%
between(simulated_data$consumption[1:4], 1, 1.1)

# Checking that the percent of energy consumption in 2009 is between
# 0.7% and 1%
between(simulated_data$consumption[5], 0.7, 1)

# Checking that the percent of energy consumption from 2010 to 2015 is between
# 0% and 1.05%
between(simulated_data$consumption[6:11], 0, 1.05)
