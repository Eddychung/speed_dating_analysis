# Gender Bias on matching

# Getting the data
dating <- read.table('../../data/SpeedDatingData.csv', header=TRUE, sep=',', fill=TRUE)

# For this part of the analysis, I want to look at the relationship between how a person 
# ranked their match with their Yes/No decision of whether they would like to date them
# grouped by gender

temp <- dating[c('dec', 'attr', 'sinc', 'intel', 'fun', 'amb', 'shar', 'gender')]
scorecard_gender <- na.omit(temp)

# Females
temp1 <- subset(scorecard_gender, gender==0)
scorecard_female <- temp1[c('dec', 'attr', 'sinc', 'intel', 'fun', 'amb', 'shar')]

# Males
temp2 <- subset(scorecard_gender, gender==1)
scorecard_male <- temp2[c('dec', 'attr', 'sinc', 'intel', 'fun', 'amb', 'shar')]

################################################

## Visual representation

png('../../images/scorecard-female-boxplot.png')
boxplot(qualities_1[,-1], horizontal=TRUE, main='Scores of Qualities in a Partner', col='cadetblue2', las=1)
dev.off()

################################################

## Correlations
correlation_matrix_female <- cor(scorecard_female)
correlation_matrix_male <- cor(scorecard_male)

### correlation matrix female - male (to obtain differences)
correlation_matrix_gender_differences <- correlation_matrix_female - correlation_matrix_male

################################################

## Regression

multiregression_female <- lm(dec ~ attr+sinc+intel+fun+amb+shar, data=scorecard_female)
multiregression_male <- lm(dec ~ attr+sinc+intel+fun+amb+shar, data=scorecard_male)

reg_summary_multi_female = summary(multiregression_female)
reg_summary_multi_male = summary(multiregression_male)

################################################

## Save

save(multiregression_female, multiregression_male, reg_summary_multi_female, reg_summary_multi_male,
     correlation_matrix_gender_differences,
     file = "../../data/regression-gender.RData")
