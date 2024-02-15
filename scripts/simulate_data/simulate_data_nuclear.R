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
# Should be 5-10% for all years
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
