# import packages
require("ggplot2")
require("latex2exp")

# define location to dataset
cdc_data_file = file.path("cdc.csv")
cdc = read.csv(cdc_data_file)

# count the number of people with excellent general health
excel_count = length(which(cdc$genhlth=="excellent"))

# create a point estimate p-hat
phat = excel_count / length(cdc$genhlth)

# calculate the standard error
se = sqrt((phat*(1-phat))/length(cdc$genhlth))

# calculate the lower and upper bounds of the CI
# do this for a 99% confidence interval
zstar = 2.576
ci_low = phat - zstar*se
ci_up = phat + zstar*se
