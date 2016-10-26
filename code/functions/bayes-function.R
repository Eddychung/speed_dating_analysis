# Bayes Analysis

# Getting the data
dating_full <- read.table('../../data/SpeedDatingData.csv', header=TRUE, sep=',', fill=TRUE)

# Want: iid (my ID), pid (their ID), dec
dating <- dating_full[c('iid', 'pid', 'dec')]
dating <- na.omit(dating)
summary(dating) # some mistakes in data entry (dec > 1)
dating <- subset(dating, dec<=1 & dec>=0)

# Creating 2 separate dataframes
dating1 <- dating
dating2 <- dating 

dating1$match_id <- do.call(paste, c(dating1[c('iid', 'pid')], sep=""))
dating2$match_id <- do.call(paste, c(dating1[c('pid', 'iid')], sep=""))

names(dating1) <- c('iid', 'pid', 'dec1', 'match_id')
names(dating2) <- c('iid', 'pid', 'dec2', 'match_id')

total <- merge(dating1, dating2, by='match_id')
total2 <- subset(total, iid.x < pid.x)

total3 <- total2[c('match_id', 'iid.x', 'pid.x', 'dec1', 'dec2')]
names(total3) <- c('match_id', 'iid', 'pid', 'iid_dec', 'pid_dec')

sample_of_data <- head(total3)

# Find conditional probabilities

iid_pid <- subset(total3, iid_dec==1 & pid_dec==1) #i like they like
iid_not_pid <- subset(total3, iid_dec==1 & pid_dec==0) #i like they don't like
not_iid_pid <- subset(total3, iid_dec==0 & pid_dec==1) #i don't like they like
not_iid_not_pid <- subset(total3, iid_dec==0 & pid_dec==0) #i don't like they don't like

YY <- nrow(iid_pid)
YN <- nrow(iid_not_pid)
NY <- nrow(not_iid_pid)
NN <- nrow(not_iid_not_pid)

Y <- YY + YN
N <- NY + NN

total_matches = nrow(total3)

YY + YN + NY + NN == total_matches #sanity check
Y + N == total_matches #sanity check

# Let A represent the dater liking their partner and let X represent the partner liking the dater
# Let Ac represent the dater not liking their partner
# We want to find the conditional probability that, given a partner likes the dater, what is the
# probability that the dater likes the partner?

# Bayes Thm
# P(A | X) = P(X | A)*P(A) / [P(X|A)*P(A) + P(X|Ac)*P(Ac)]
pXA = YY/total_matches
pA = Y/total_matches
pXAc = NY/total_matches
pAc = N/total_matches

pAX = (pXA*pA) / ((pXA*pA) + (pXAc*pAc)) # P(A|X)

# Matrix Representation
probs = matrix(c(YY, YN, NY, NN), 2, 2, byrow = TRUE, 
               dimnames = list(c("Y_them", "N_them"), c("Y_me", "N_me")))

probs = cbind(probs, rowSums(probs))
probs = rbind(probs, colSums(probs))
colnames(probs)[3] = "Total1"
rownames(probs)[3] = "Total2"

probs_percentages = matrix(c(YY/total_matches, YN/total_matches, NY/total_matches, NN/total_matches), 
                           2, 2, byrow=TRUE,
                           dimnames = list(c("Y_them", "N_them"), c("Y_me", "N_me")))

probs_percentages = cbind(probs_percentages, rowSums(probs_percentages))
probs_percentages = rbind(probs_percentages, colSums(probs_percentages))
colnames(probs_percentages)[3] = "Total1"
rownames(probs_percentages)[3] = "Total2"

probs_percentages

# Save

save(probs, probs_percentages, pAX, sample_of_data,
     file = "../../data/bayes-data.RData")


