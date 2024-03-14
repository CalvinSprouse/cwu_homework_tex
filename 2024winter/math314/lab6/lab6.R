# import packages
require("ggplot2")
require("latex2exp")

# define location to dataset
nfl_data_file = file.path("nfl.csv")
nfl = read.csv(nfl_data_file)

# random guess vs oddsmakers
# define a new variable fav_win
# fav_win is true if the favored team pts > un pts
nfl$fav_win = nfl$fav_pts > nfl$un_pts

# hypothesis test of random vs favored
# H_0: p = 0.5, H_1: p > 0.5
# have to invert it because R inverts my table :(
# change to manual entry of n/p and stuff
oddsmaker_hyp_test = prop.test(
  x=sum(nfl$fav_win, na.rm=TRUE),
  n=length(nfl$fav_win),
  p=0.5,
  alternative="greater",
  correct=FALSE
)

# hypothesis test of home adv
homeadv_hyp_test = prop.test(
  table(nfl$fav_win, nfl$home),
  alternative="two.sided",
  correct=FALSE
)

# how often are the points scored by the fav - un >= spread
nfl$fav_un_geq_spread = nfl$fav_pts - nfl$un_pts >= nfl$pt_spread

# how often the spread is covered is truth count over total
# calculate a point-estimate
phat_spread = sum(nfl$fav_un_geq_spread, na.rm=TRUE) / length(nfl$fav_un_geq_spread)

# calculate the margin of error
se_phat_spread = sqrt((phat_spread*(1-phat_spread))/length(nfl$fav_un_geq_spread))
z_star = 1.965
margin_of_error = z_star*se_phat_spread

# calculate the confidence interval
ci_min = phat_spread - margin_of_error
ci_max = phat_spread + margin_of_error
