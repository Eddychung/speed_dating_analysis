# Regression Analysis

# Getting the data
dating <- read.table('../../data/SpeedDatingData.csv', header=TRUE, sep=',', fill=TRUE)

# For this part of the analysis, I want to look at the relationship between how a person 
# ranked their match with their Yes/No decision of whether they would like to date them

scorecard_full <- dating[c('dec', 'attr', 'sinc', 'intel', 'fun', 'amb', 'shar', 'like', 'prob', 'met')] #keeping variables for later if time permits
temp <- dating[c('dec', 'attr', 'sinc', 'intel', 'fun', 'amb', 'shar')]
scorecard <- na.omit(temp)

##############################

# Singular linear regressions
reg1 = lm(dec ~ attr, data=scorecard)
reg_summary_attr = summary(reg1)

reg2 = lm(dec ~ sinc, data=scorecard)
reg_summary_sinc = summary(reg2)

reg3 = lm(dec ~ intel, data=scorecard)
reg_summary_intel = summary(reg3)

reg4 = lm(dec ~ fun, data=scorecard)
reg_summary_fun = summary(reg4)

reg5 = lm(dec ~ amb, data=scorecard)
reg_summary_amb = summary(reg5)

reg6 = lm(dec ~ shar, data=scorecard)
reg_summary_shar = summary(reg6)

# Scatterplot
library(ggplot2)

scatterplot_attrXmatch = (ggplot(data=scorecard, aes(attr, dec)) 
                        + ggtitle('Attractiveness vs. Match') 
                        + geom_point(color='gold')
                        + stat_smooth(method="lm"))

scatterplot_sincXmatch = (ggplot(data=scorecard, aes(sinc, dec)) 
                          + ggtitle('Sincerity vs. Match') 
                          + geom_point(color='gold')
                          + stat_smooth(method="lm"))

scatterplot_intelXmatch = (ggplot(data=scorecard, aes(intel, dec)) 
                          + ggtitle('Intelligence vs. Match') 
                          + geom_point(color='gold')
                          + stat_smooth(method="lm"))

scatterplot_funXmatch = (ggplot(data=scorecard, aes(fun, dec)) 
                           + ggtitle('Fun vs. Match') 
                           + geom_point(color='gold')
                           + stat_smooth(method="lm"))

scatterplot_ambXmatch = (ggplot(data=scorecard, aes(amb, dec)) 
                           + ggtitle('Ambition vs. Match') 
                           + geom_point(color='gold')
                           + stat_smooth(method="lm"))

scatterplot_sharXmatch = (ggplot(data=scorecard, aes(shar, dec)) 
                           + ggtitle('Shared Interests vs. Match') 
                           + geom_point(color='gold')
                           + stat_smooth(method="lm"))

################################################
################################################
################################################

## Correlations
correlation_matrix <- cor(scorecard)

## Scatterplot matrix
#Scatterplot Matrices from the glus Package 
library(gclus)
scorecard.r <- abs(cor(scorecard)) # get correlations
scorecard.col <- dmat.color(scorecard.r) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
scorecard.o <- order.single(scorecard.r) 
png('../../images/scatterplot-matrix.png')
cpairs(scorecard, scorecard.o, panel.colors=scorecard.col, gap=.7,
       main="Scatterplot Matrix" )
dev.off()

################################################
################################################
################################################

## Multivariate Linear Regression

multiregression <- lm(dec ~ attr+sinc+intel+fun+amb+shar, data=scorecard)
reg_summary_multi = summary(multiregression)

## Residual Plot
png('../../images/residual-plot.png')
plot(multiregression, which=1)
dev.off()

## Scale Location Plot
png('../../images/scale-location.png')
plot(multiregression, which=3)
dev.off()

## Normal QQ Plot
png("../../images/normal-qq-plot.png")
plot(multiregression, which=2)
dev.off()


################################################
################################################
################################################

## Save all to RData

save(multiregression, reg_summary_attr, reg_summary_sinc, reg_summary_intel, reg_summary_fun, reg_summary_amb, reg_summary_shar,
     scatterplot_attrXmatch, scatterplot_sincXmatch, scatterplot_intelXmatch,
     scatterplot_funXmatch, scatterplot_ambXmatch, scatterplot_sharXmatch,
     reg_summary_multi, file = "../../data/regression.RData")
save(correlation_matrix, file = "../../data/correlation-matrix.RData")

