# import packages
require("ggplot2")
require("latex2exp")

# define location to dataset
cdc_data_file = file.path("~/program/math314_stats/cdc.csv")
cdc = read.csv(cdc_data_file)

# ggplot2 histogram and boxplot from cdc data
ggplot(
  cdc,
  aes(x=height)
) + geom_histogram(
  color="white",
  fill="grey"
) + geom_boxplot() + labs(
  x=TeX(r"(Height [in])"),
  y=TeX(r"(Frequency)"),
  title=TeX(r"(Histogram of CDC Respondent Height)")
) + theme_dark()

# binomial distribution
sims = (rbinom(1000, 50, 0.75))
data = data.frame(sims)

# summarize plotting statistics to a dataframe
sumstatz <- data.frame(
  whichstat = c("mu", "+sigma", "-sigma"),
  value = c(mean(data$sims),
            mean(data$sims) + sd(data$sims),
            mean(data$sims) - sd(data$sims))
)

# plot
ggplot(
  data,
  aes(x=sims)
) + geom_histogram(
  aes(y=..density..),
  binwidth=1,
  color="white"
) + labs(
  x=TeX(r"(Probability of the value)"),
  y=TeX(r"(Normalized Frequency)"),
  title=TeX(r"(Histogram of a binomial distribution)"),
  subtitle=TeX(r"($N=1000,n=50,p=0.75$)")
) + geom_vline(
  data=sumstatz,
  aes(xintercept=value,
      linetype=whichstat,
      col=whichstat),
  color="black",
  linetype="dashed",
  linewidth=0.7,
) + annotate(
  x=sumstatz$value[1],
  y=0.05,
  label=TeX(
    paste(r"(\mu =)",
          as.character(signif(sumstatz$value[1], 2)),
          r"(\pm\sigma =)",
          as.character(signif(sumstatz$value[2]-sumstatz$value[1], 2))
          )),
  vjust=2,
  geom="label"
)


# define a function to take an input for either p or n for a binom and
# run 1000 simulations then graph the results
test_binom = function(n=50, p=0.75){
  # binomial distribution
  sims = (rbinom(1000, n, p))
  data = data.frame(sims)
  
  # summarize plotting statistics to a dataframe
  sumstatz <- data.frame(
    whichstat = c("mu", "+sigma", "-sigma"),
    value = c(mean(data$sims),
              mean(data$sims) + sd(data$sims),
              mean(data$sims) - sd(data$sims))
  )
  
  # plot
  ggplot(
    data,
    aes(x=sims)
  ) + geom_histogram(
    aes(y=..density..),
    binwidth=1,
    color="white"
  ) + labs(
    x=TeX(r"(Probability of the value)"),
    y=TeX(r"(Normalized Frequency)"),
    title=TeX(r"(Histogram of a binomial distribution)"),
    subtitle=TeX(
      paste(
        r"($N=1000,n=)",
        as.character(n),
        r"(,p=)",
        as.character(p),
        r"($)"
        ))
  ) + geom_vline(
    data=sumstatz,
    aes(xintercept=value,
        linetype=whichstat,
        col=whichstat),
    color="black",
    linetype="dashed",
    linewidth=0.7,
  ) + annotate(
    x=sumstatz$value[1],
    y=0.05,
    label=TeX(
      paste(r"(\mu =)",
            as.character(signif(sumstatz$value[1], 2)),
            r"(\pm\sigma =)",
            as.character(signif(sumstatz$value[2]-sumstatz$value[1], 2))
      )),
    vjust=2,
    geom="label"
  )
}

# verify function
test_binom()

# binomial p=0.5
test_binom(p=0.5)

# binomial p=0.1
test_binom(p=0.1)

# binomial p=0.9
test_binom(p=0.9)

# binomial p=.25
test_binom(p=0.25)

# binomial n=10
test_binom(n=10)

# binomial n=25
test_binom(n=25)

# binomial n=100
test_binom(n=100)

# binomial n=1000
test_binom(n=1000)
