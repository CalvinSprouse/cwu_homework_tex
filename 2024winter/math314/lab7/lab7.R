# import libraries
require("ggplot2")
require("latex2exp")

# load the data
load("data/nc.Rdata")


# part 1. chi-square test on low birth weight
# in smoking and non-smoking mothers
# H_0: there is no difference
# H_1: there is a difference
# alpha = 0.05.
pval_pt1 = chisq.test(table(nc$habit, nc$lowbirthweight))


# part 2. a 90% confidence interval for the
# weight gained by mother during pregnancy

# remove rows that contain an NA in the gain column
gain_data = na.omit(nc$gained)

# calculate some values to use later
mean_gain = mean(gain_data)
n_samples = length(gain_data)
margin_error = qt(0.9, n_samples - 1)*(sd(gain_data)/sqrt(n_samples))

# calculate the lower and upper bounds of the CI
ci_low = mean_gain - margin_error
ci_hi = mean_gain + margin_error


# part 3. is the typical length of pregnancies
# less than 39 weeks?
# H_0: mu = 39
# H_1: mu < 39
# p-val = P(T < t)
# alpha = 0.05
pval_pt2 = t.test(
  na.omit(nc$weeks),
  mu=39,
  alternative="l",
  conf.level=0.9
)


# bonus. do younger mothers and mature mothers have different
# expected weight gains?
# H_0: mu_y = mu_m
# H_1: mu_y =/= mu_m
# p-val = 2*P(T > |t|)
# alpha = 0.05

# define young_gain and mature_gain data
young_gain = na.omit(nc[nc$mature == "younger mom",]$gained)
mature_gain = na.omit(nc[nc$mature == "mature mom",]$gained)

# conduct t-test
pval_pt3 = t.test(young_gain, mature_gain, conf.level=0.9)
