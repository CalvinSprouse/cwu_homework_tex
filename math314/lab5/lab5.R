# install packages
install.packages("knitr")
install.packages("plotrix")

# import packages
require(knitr)
require(plotrix)
require(latex2exp)

# generate point-estimates for a binomial experiment 
samples = rbinom(100, 150, .6)

# calculate phat for each sample
phat = samples/150

# determine the bounds of the 90% confidence interval for each sample
leftconflimits = phat -1.645*sqrt(phat*(1-phat)/150)
rightconflimits = phat + 1.645*sqrt(phat*(1-phat)/150)

# show the first couple entries of the lower bound list
head(leftconflimits)

# create a new table with two columns, one for each limit
conflimits = cbind(leftconflimits, rightconflimits)

# show the first couple entries of the confidence limit table
head(conflimits)

# define the colors for the plot
# red denotes "outliers"
# black denotes "expected" or within 95% confidence interval
mycolors = ifelse(.6 < leftconflimits | .6 > rightconflimits, "Red", "Black")

# plot the values of phat with their confidence intervals
plotCI(
  x=1:100,
  y=phat,
  li=conflimits[,1],
  ui=conflimits[,2],
  col=mycolors,
  ylim=c(.4,.8),
  xlab=TeX(r"(sample number)"),
  ylab=TeX(r"($\hat{p}$)"),
  main=TeX(r"(100 Point estimates of $\hat{p}$ for a binomial distribution)"),
  sub=TeX(r"($n=150, p=0.6$)")
)

# draw a line denoting the phat average
abline(h=.6)
