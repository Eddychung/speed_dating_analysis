## Speed Dating Analysis 

### Author

Lauren Hanlon

## About the Data

For this analysis I will refer to a "speed dating" experiment conducted in 2006. You can find the data [here](https://cl.ly/2Y3I1d3b0p2N/Archive%202014-08-05%20at%201.27.45%20AM.zip).

More background on the experiment:

> "In the experiment, a few hundred students in several waves were randomly assigned to 10 short dates. At the end of each 4-minute date each participant filled out a scorecard that asked them to decide whether or not they would like to see the other person again (1=yes or 0=no). The participants were also asked to record subjective numerical ratings for the other person (attractive, sincere, intelligent, fun, ambitions, has shared interests/hobbies). A pre-interview and a follow-up survey also captured data about participants' backgrounds, preferences, and some other characteristics."

## Goal

My goal for this project was to answer 3 key questions:

1. Disucss and quantify the importance, in general, of each person a's 6 ratings of person b (attractiveness, sincerity, intelligence and so forth) in determining of person a is interested in seeing person b again.

2. Some people are more likely to want to see other people again. Discuss the implications for the general conclusions you reached in question 1 and see if you can account and correct for this kind of underlying variation in the person making the evaluation.

3. With some people, it is more likely that others will want to see them again. Is there evidence in the data for this kind of variation in the person being rated? If so, how can you account and correct for it and what are the implications for your conclusions in 1 & 2.

BONUS: Create a story about interesting relationships or findings in that you have uncovered in the data. 

### File Structure

<pre><code>speed_dating_analysis/
README.md
Makefile
code/
 README.md
 functions/
  regression-functions.R
  bayes-function.R
 scripts/
  dating-similarity-script.R
  eda-script.R
  gender-bias-script.R
  regression-script.R
data/
 README.md
 bayes-data.RData
 correlation-matrix.RData
 eda-output.txt
 regression-gender.RData
 regression.RData
 SpeedDatingData.csv
images/
 *.png
report/
 report.Rmd
 report.pdf
session-info.txt
.gitignore
</code></pre>

### How to reproduce this project

1. Clone this github repository
2. Make sure SpeedDatingData.csv is saved in the _data_ folder
3. Within the directory `./speed-dating-analysis`, in the command line type `make all`. This will run the R scripts to create the images, save this data then use it within the Rmd file to produce the final report.

Each script and function produces a different analysis in the final report. Images are all produced within script files, and are used in the final report. Data is saved from all scripts and functions in the data folder in the RData format.

### Packages Used

`ggplot2`, `stargazer`, `reshape`
