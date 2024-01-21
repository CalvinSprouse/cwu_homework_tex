# load the latex graphing package
library("latex2exp")

# create the "dice" and define sample size
dice <- 1:6
samples = 1000000

# create a table of two dice rolls
dice1 = sample(dice, size=samples, replace=TRUE)
dice2 = sample(dice, size=samples, replace=TRUE)
dice_df <- data.frame(dice1, dice2)

# calculate the sum
dice_df$sum <- dice_df$dice1 + dice_df$dice2

# plot the dice sum
hist(
  x=dice_df$sum,
  xlab=TeX(r"(Sum)"),
  ylab=TeX(r"(Frequency)"),
  main=TeX(r"(Histogram of the sum of two six-sided dice rolled 100000 times)"),
  freq=TRUE
)
