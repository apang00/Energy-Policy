#### Preamble ####
# Purpose: Simulates nuclear energy production in Japan from 2005 to 2015.
# Date: 14 February 2024
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(123) # For reproducibility 

n <- 11 # Number of years in the figure from 2005 to 2015

years_nuclear <- rep(NA, times=n)

# Percent of nuclear energy production from 2005 to 2010
# Should be 20-30% for all years
for (i in 1:6) {
  years_nuclear[i] <- (sample(20:30, 1))
}

# Percent of nuclear energy production in 2011
# Should be 5-10%
years_nuclear[7] <- (sample(5:10, 1))

# Percent of nuclear energy production from 2012 to 2015
# Should be 0-5% for all years
for (i in 8:n) {
  years_nuclear[i] <- (sample(0:5, 1))
}

simulated_data <-
  tibble(
    year = 2005:2015,
    percent_nuclear = years_nuclear
  )

ggplot(simulated_data, aes(x = year, y = percent_nuclear)) +
  geom_line() +
  geom_point() +
  labs(title = "Percent of Nuclear Energy Produced Domestically", 
       x = "Year", y = "Percent of Nuclear Energy Produced")


#### Test data ####

# Checking that there are only 11 years involved from 2005 to 2015
simulated_data$year |> length() == 11

# Checking that the only years involved are from 2005 to 2015 in that order
simulated_data$year == c(2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 
                         2014, 2015)

# Checking the classes of the columns
simulated_data$year |> class() == "integer"
simulated_data$percent_nuclear |> class() == "integer"

# Checking that the percent of nuclear energy production for all years is
# between 0% and 30%
between(simulated_data$percent_nuclear, 0, 30)

# Checking that the percent of nuclear energy production from 2005 to 2010
# is between 20% and 30%
between(simulated_data$percent_nuclear[1:6], 20, 30)

# Checking that the percent of nuclear energy production in 2011 is between
# 5% and 10%
between(simulated_data$percent_nuclear[7], 5, 10)

# Checking that the percent of nuclear energy production from 2012 to 2015
# is between 0% and 5%
between(simulated_data$percent_nuclear[8:11], 0, 5)
