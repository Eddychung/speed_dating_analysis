# Exploratory data analysis

# Getting the data

dating <- read.table('../../data/SpeedDatingData.csv', header=TRUE, sep=',', fill=TRUE)

# Subsetting based on waves

# Waves 6-9 had to rate the importance of attributes in a potential date on a scale of 1-10
dating_scales <- subset(dating, wave>=6 & wave<=9)
temp <- dating_scales[c('attr1_1', 'sinc1_1', 'intel1_1', 'fun1_1', 'amb1_1', 'shar1_1')]
qualities_1 <- na.omit(temp)
names(qualities_1) <- c('Attractive', 'Sincere', 'Intelligent', 'Fun', 'Ambitious', 'Shared Interests')

# Waves 1-5, 10-21 had 100 points to distrubte among the following attributes
dating_distribute <- subset(dating, wave<=5 | wave>=10)
temp2 <- dating_distribute[c('attr1_1', 'sinc1_1', 'intel1_1', 'fun1_1', 'amb1_1', 'shar1_1')]
qualities_2 <- na.omit(temp2)
names(qualities_2) <- c('Attractive', 'Sincere', 'Intelligent', 'Fun', 'Ambitious', 'Shared Interests')

# Summary statistics
summary_qual1 <- summary(qualities_1)
summary_qual2 <- summary(qualities_2)

##############################
# Scaled stats

# Histograms for scaled stats

## Attractive
png('../../images/histogram-attractive-scaled.png')
hist(qualities_1$Attractive, xlab='attractiveness importance', breaks=10, main='Attractiveness Histogram', col='cadetblue3', ylim=c(0, 500), xlim=c(0,30))
dev.off()

## Sincere
png('../../images/histogram-sincere-scaled.png')
hist(qualities_1$Sincere, xlab='sincerity importance', breaks=15, main='Sincereity Histogram', col='cadetblue3', ylim=c(0, 450), xlim=c(0,25))
dev.off()

## Intelligent
png('../../images/histogram-intelligent-scaled.png')
hist(qualities_1$Intelligent, xlab='intelligence importance', breaks=10, main='Intelligence Histogram', col='cadetblue3', ylim=c(0, 450), xlim=c(0,25))
dev.off()

## Fun
png('../../images/histogram-fun-scaled.png')
hist(qualities_1$Fun, xlab='fun importance', breaks=10, main='Fun Histogram', col='cadetblue3', ylim=c(0, 600), xlim=c(0,30))
dev.off()

## Ambition
png('../../images/histogram-ambitious-scaled.png')
hist(qualities_1$Ambitious, xlab='ambitious importance', breaks=10, main='Ambition Histogram', col='cadetblue3', ylim=c(0, 500), xlim=c(0,30))
dev.off()

## Shared interests/hobbies
png('../../images/histogram-shared-scaled.png')
hist(qualities_1$Shared, xlab='shared interests importance', breaks=10, main='Shared Interests Histogram', col='cadetblue3', ylim=c(0, 400), xlim=c(0,25))
dev.off()

## Visualize Means
png('../../images/qualities-score-plot.png')
boxplot(qualities_1, horizontal=TRUE, main='Scores of Qualities in a Partner', col='cadetblue2', las=1)
dev.off()

##############################

# Distributed values
# Want to look at buckets as a fraction then visually represent that

percentages <- qualities_2
percentages <- percentages/100 #scale values to percentages
summary_percentages <- summary(percentages)

library(ggplot2)
library(reshape2)    # for melt(...)
df <- melt(percentages)

qualities_scaled_plot <- ggplot(df, aes(x=variable,y=value)) +
  stat_summary(fun.y=mean,geom="bar",color="grey20",fill="cadetblue")+
  stat_summary(fun.data="mean_sdl")+
  ggtitle('Distributed Weights of Qualities in a Partner')+
  xlab('Qualities')

png('../../images/qualities-distrubted-plot.png')
qualities_scaled_plot
dev.off()

##############################

## Save Outputs to txt file and RData file
capture.output(summary_qual1, summary_qual2, summary_percentages, file = "../../data/eda-output.txt")
