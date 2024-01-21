# import packages
require("ggplot2")
require("latex2exp")

# define location to dataset
cdc_data_file = file.path("blood.csv")
cdc = read.csv(cdc_data_file)


# assignment part 1
# generate normal and uniform data
rnorm_data = rnorm(n=1000, mean=1, sd=0.577)
unif_data = runif(n=1000, min=0, max=2)

# create histogram of normal data
ggplot(
  mapping=aes(rnorm_data)
) + geom_histogram(
  color="black",
  binwidth=0.2,
) + labs(
  x=TeX(r"(Sample Value)"),
  y=TeX(r"(Frequency)"),
  title=TeX(r"(Histogram of normally distributed sample data)"),
  subtitle=TeX(r"($N=1000,\mu=1,\sigma=0.577,$ Bin Width$= 0.2$)")
)
ggsave(filename="lab3/rnorm_sample.pdf")

# create histogram of uniform data
ggplot(
  mapping=aes(unif_data)
) + geom_histogram(
  color="black",
  binwidth=0.2,
  origin=0
) + labs(
  x=TeX(r"(Sample Value)"),
  y=TeX(r"(Frequency)"),
  title=TeX(r"(Histogram of uniformally distributed sample data)"),
  subtitle=TeX(r"($N=1000,$ min$= 0$, max$= 2$, Bin Width$= 0.2$)")
)
ggsave(filename="lab3/unif_sample.pdf")

# create qq-plot of normal data
ggplot(
  mapping=aes(sample=rnorm_data)
) + stat_qq() + stat_qq_line() + labs(
  x=TeX(r"(Theoretical Quantile)"),
  y=TeX(r"(Sample Quantile)"),
  title=TeX(r"(QQ-plot of normally distributed sample data)"),
  subtitle=TeX(r"($N=1000,\mu=1,\sigma=0.577$)")
)
ggsave(filename="lab3/rnorm_qq.pdf")

# create qq-plot of uniform data
ggplot(
  mapping=aes(sample=unif_data)
) + stat_qq() + stat_qq_line() + labs(
  x=TeX(r"(Theoretical Quantile)"),
  y=TeX(r"(Sample Quantile)"),
  title=TeX(r"(QQ-plot of uniformally distributed sample data)"),
  subtitle=TeX(r"($N=1000,$ min$= 0$, max$= 2$)")
)
ggsave(filename="lab3/unif_qq.pdf")

# assignment part 2
# generate a qq-plot of systolic blood pressure
ggplot(
  data=cdc,
  mapping=aes(sample=systolicbp)
) + stat_qq() + stat_qq_line() + labs(
  x=TeX(r"(Theoretical Quantile)"),
  y=TeX(r"(Sample Quantile)"),
  title=TeX(r"(QQ-plot of systolic blood pressure in CDC respondents)")
)
ggsave(filename="lab3/systbp_qq.pdf")

# generate a qq-plot of systolic blood pressure for non-smokers vs smokers
ggplot(
  data=cdc,
  mapping=aes(
    sample=systolicbp,
    colour=factor(smoke)
  )
) + stat_qq() + stat_qq_line() + labs(
  x=TeX(r"(Theoretical Quantile)"),
  y=TeX(r"(Sample Quantile)"),
  title=TeX(r"(QQ-plot of systolic blood pressure in CDC respondents)"),
  subtitle=TeX(r"(data seperated by respondent smoking status)")
)
ggsave(filename="lab3/systbp_qq_comp.pdf")
