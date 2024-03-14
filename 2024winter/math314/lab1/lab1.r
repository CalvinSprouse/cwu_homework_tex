# script configuration
# define a path to the data directory: "~/local_data/statistics_math314"
data_dir <- "~/local_data/statistics_math314"

# import the "cdc-1.csv" dataset
cdc <- read.csv(file.path(data_dir, "cdc-1.csv"))


# problem 1
# represent the distribution of a categorical variable: 'genhlth'
# do this for male and female respondents to if there is a difference
# in self-reported general health
# order the categories logically from left to right:
# excellent, very good, good, fair, poor

# order the genhlth categories logically
genhlth_order <- c("excellent", "very good", "good", "fair", "poor")

# create the subsets for male and female respondents
# there are no other gender responses in the cdc dataset to consider
male_cdc <- subset(cdc, cdc$gender == "m")
female_cdc <- subset(cdc, cdc$gender == "f")

# count the responses in each category per dataset
# the factor method ensures there will be an entry for each category
# this is important because the male subset containes no responses of 'poor'
male_genhlth_counts <- table(factor(male_cdc$genhlth, levels=genhlth_order))
female_genhlth_counts <- table(factor(female_cdc$genhlth, levels=genhlth_order))

# determine the maximum count to create universal y-scale
max_male_count <- max(male_genhlth_counts)
max_female_count <- max(female_genhlth_counts)
max_count <- max(max_male_count, max_female_count)

# create a barplot for each subset
barplot(male_genhlth_counts, 
        beside = TRUE, 
        col = "black",
        names.arg = genhlth_order,
        xlab = "Self-Assesment of General Health",
        ylab = "Number of Responses",
        main = "Distribution of Percieved Health in Males",
        ylim = c(0, max_count))

barplot(female_genhlth_counts, 
        beside = TRUE, 
        col = "black",
        names.arg = genhlth_order,
        xlab = "Self-Assesment of General Health",
        ylab = "Number of Responses",
        main = "Distribution of Percieved Health in Females",
        ylim = c(0, max_count))


# problem 2
# investigate the distribution of the height of cdc respondents
boxplot_height <- boxplot(cdc$height,
        main = "Height of Respondents in Inches",
        col = "gray",
        border = "black",
        horizontal = TRUE)

# add text labels for numerical values
text(x = boxplot_height$stats, 
     y = rep(1.1, length(boxplot_height$stats)), 
     labels = round(boxplot_height$stats, 2), 
     pos = 3, 
     offset = 3, 
     col = "black")


# problem 3
# investigate weather having a health plan encourages people to lose weight
# first define a new column 'weightdelta' which records the difference of
# a respondent current weight and desired weight
cdc$weightdelta <- cdc$weight - cdc$wtdesire

# seperate cdc into two subsets, one with respondents who have a health plan
# and one where respondents do not have a healthplan
haveplan = subset(cdc, cdc$hlthplan == 1)
noplan = subset(cdc, cdc$hlthplan == 0)

# make whisker plots of each subset
boxplot_plan <- boxplot(
  haveplan$weightdelta,
  main = "Desired Weight Change of Respondents with a Health Plan",
  col = "gray",
  border = "black",
  horizontal = TRUE)

text(
  x = boxplot_plan$stats,
  y = rep(1.1, length(boxplot_plan$stats)),
  labels = round(boxplot_plan$stats, 2),
  pos = 3,
  offset = 3,
  col = "black"
)

boxplot_noplan <- boxplot(
  noplan$weightdelta,
  main = "Desired Weight Change of Respondents without a Health Plan",
  col = "gray",
  border = "black",
  horizontal = TRUE)

text(
  x = boxplot_noplan$stats,
  y = rep(1.1, length(boxplot_noplan$stats)),
  labels = round(boxplot_noplan$stats, 2),
  pos = 3,
  offset = 3,
  col = "black"
)
