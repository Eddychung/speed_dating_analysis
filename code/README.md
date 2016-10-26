## Code

### Scripts

`session-info-script.R` lists the required packages needed for this project, including `ggplot2`, `stargazer`, and `reshape`. It's output is saved in `session-info.txt` in the main directory.

All remaining scripts first upload data from SpeedDatingData.csv in the _data_ folder.

`eda-script.R` is my exploratory data analysis. It produces visual representations of the frequencies of each quality in the form of a histogram and saves these histograms in the _images_ folder in png format. It also produces a table of summary statistics for the data. These tables are saved in the _data_ folder as `eda-output.txt`.

`regression-script.R` uses the `lm` package in R to first produce simple regression models between each predictor and the response. It then creates a multivariable regression model as well as correlated residual, scale and QQ plots. The data from this and the correlation matrix are stored in `regression.RData` and `correlation-matrix.RData`, respectively. All png images are saved in the _images_ folder.

`dating-similar-script.R` explores the relationship between a dater's ratings of themself versus their ratings of people they are meeting, and how that relates to who they would like to see again. Boxplots of the distributions are saved as pngs in the _images_ folder.

`gender-bias-script.R` looks at the differences between men and women in who they would like to see again. It uses the `lm` package in R to produce multivariable regression models. Correlation matricies are also made to observe the absolute differences between male and female preferences. All data is saved in `regression-gender.RData` and all png images are saved in the _images_ folder.

### Functions

`bayes-function.R` contains the code to produce a Bayesian depiction of the relationship between a dater and partner. Specifically, it looks at the conditional probabilities that given a dater likes a partner, what is the probability that partner likes the dater in return.

`regression-functions.R` contains functions to produe the residual sum of squares, total sum of squres, r-squared statistic, f-statistic as well as the residual standard error.