#### Simulation for Heatstroke Analysis ####

# The years for the data will be between 2008 and 2015
years <- 2008:2015

# The heatstroke cases will be randomly generated. However, there should be a
# difference between the years before and after the energy policy theoretically
heatstroke_cases <- numeric(length(years))
for (i in 1:length(years)) {
  if (years[i] < 2011) {
    heatstroke_cases[i] <- sample(3000:6000, 1)
  } else if (years[i] < 2013) {
    heatstroke_cases[i] <- sample(5000:10000, 1)
  } else {
    heatstroke_cases[i] <- sample(3000:6000, 1)
  }
}

# combine the years and heatstroke cases into a single dataframe
data <- data.frame(Years = years, Heatstroke_Cases = heatstroke_cases)

# Plotting
barplot(data$Heatstroke_Cases, names.arg = data$Years, xlab = "Years", ylab = "Heatstroke Cases", main = "Heatstroke Cases per Year")

#### Tests for Heatstroke Simulation ####

# test if the years in the data set are from the appropriate years
test1 <- all(data$Years == 2008:2015)

# test to see if all heatstroke cases are within the given range
test2 <- all(data$Heatstroke_Cases >= 3000 & data$Heatstroke_Cases <= 10000)

# test that the length of the years and heatstroke cases are the same
test3 <- length(data$Years) == length(data$Heatstroke_Cases)

# If any of the 3 tests fail or return false, there is an issue with the data.
test1
test2
test3

