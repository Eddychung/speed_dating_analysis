# Dating similarities

# Getting the data
dating_full <- read.table('../../data/SpeedDatingData.csv', header=TRUE, sep=',', fill=TRUE)

# Want data on the person at hand as well as data on their rankings for those they met
dating <- dating_full[c('iid', 'dec', 'attr3_1', 'sinc3_1', 'intel3_1', 'fun3_1', 'amb3_1', 'attr', 'sinc', 'intel', 'fun', 'amb')]

# Clean up data
dating <- na.omit(dating)
summary(dating) # some mistakes in data entry (dec > 1)
dating <- subset(dating, dec<=1 & dec>=0) # delete where dec > 1

dating$attractive_similarity <- abs(dating$attr3_1 - dating$attr)
dating$sincerity_similarity <- abs(dating$sinc3_1 - dating$sinc)
dating$intelligence_similarity <- abs(dating$intel3_1 - dating$intel)
dating$fun_similarity <- abs(dating$fun3_1 - dating$fun)
dating$abition_similarity <- abs(dating$amb3_1 - dating$amb)

similarity <- dating[c('dec', 'attractive_similarity', 'sincerity_similarity', 'intelligence_similarity',
                       'fun_similarity', 'abition_similarity')]

names(similarity) <- c('dec', 'attractive', 'sincerity', 'intelligence', 'fun', 'ambition')

liked <- subset(similarity, dec==1)
no_liked <- subset(similarity, dec==0)

## Visualize Means
png('../../images/similarity-liked.png')
boxplot(liked, horizontal=TRUE, main='Similarity Ratings of Partner: Yes', col='cadetblue2', las=1)
dev.off()

png('../../images/similarity-no-liked.png')
boxplot(no_liked, horizontal=TRUE, main='Similarity Ratings of Partner: No', col='cadetblue2', las=1)
dev.off()
