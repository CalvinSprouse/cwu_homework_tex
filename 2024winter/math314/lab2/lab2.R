# load the latex graphing package
install.packages('latex2exp')
library("latex2exp")

# script configuration
# define a path to the data directory: "~/local_data/statistics_math314"
data_dir <- "~/local_data/statistics_math314"

# import the "cdc-1.csv" dataset
cdc <- read.csv(file.path(data_dir, "cdc-1.csv"))

# compute a new column, desired weight change
cdc$wtdelta = cdc$wtdesire - cdc$weight


# part 1 create a simple scatterplot
plot(
  x=cdc$weight,
  y=cdc$wtdelta,
  xlab=TeX(r"(Weight [lbs])"),
  ylab=TeX(r"(Desired Weight Change [lbs])"),
  main=TeX(r"(CDC survey respondents weight and desired weight)"),
  pch=16,
  col="black"
)


# part 2 create a scatter plot using subsets
recently_exercise <- subset(cdc, cdc$exerany == 1)
notrecently_exercise <- subset(cdc, cdc$exerany == 0)

# plot the two groups on a scatter plot
scatter_plot <- plot(
  x=recently_exercise$weight,
  y=recently_exercise$wtdelta,
  
  col = "black",
  pch = 16,
  xlab = TeX(r"(Weight [lbs])"),
  ylab = TeX(r"(Desired Weight Change [lbs])"),
  main = TeX(r"(CDC survey respondents weight goals and exercise history)"),
  
  xlim = c(min(c(recently_exercise$weight, notrecently_exercise$weight)),
           max(c(recently_exercise$weight, notrecently_exercise$weight))),
  ylim = c(min(c(recently_exercise$wtdelta, notrecently_exercise$wtdelta)),
           max(c(recently_exercise$wtdelta, notrecently_exercise$wtdelta)))
)

points(
  notrecently_exercise$weight,
  notrecently_exercise$wtdelta,
  col = "azure4",
  pch = 17
)

legend(
  "topright",
  
  legend = c(
    TeX(r"(Exercised Recently)"),
    TeX(r"(Not Exercised Recently)")
    ),
  
  col = c(
    "black",
    "azure4"
    ),
  
  pch = c(
    16,
    17)
)
