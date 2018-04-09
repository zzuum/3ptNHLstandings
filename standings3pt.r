setwd('~/Projects/NHL/')
standings.all <- read.csv('2018standings.csv')
# Getting overtime wins and losses
standings.all$OTW <- sapply(strsplit(
  as.character(standings.all$Overtime), '-'),`[`, 1)
standings.all$OTL <- sapply(strsplit(as.character(
  standings.all$Overtime), '-'),`[`, 2)
# Getting shootout wins and losses
standings.all$SOW <- sapply(strsplit(as.character(
  standings.all$Shootout), '-'),`[`, 1)
standings.all$SOL <- sapply(strsplit(as.character(
  standings.all$Shootout), '-'),`[`, 2)
# Regulation wins
standings.all$RW <-  sapply(strsplit(as.character(
  standings.all$Overall), '-'),`[`, 1)
# Converting characters to numerics
standings.all$RW <- as.numeric(standings.all$RW)
standings.all$OTW <- as.numeric(standings.all$OTW)
standings.all$SOW <- as.numeric(standings.all$SOW)
standings.all$OTL <- as.numeric(standings.all$OTL)
standings.all$SOL <- as.numeric(standings.all$SOL)
# Correct regulation wins
standings.all$RW <- standings.all$RW - standings.all$OTW - standings.all$SOW

# Calculations! 3 points for regulation wins, 2 points for OT win, 2 points for 
# SO win, 1 point for OT loss, 1 point for SO loss
# Also, ROW are used for points tie breakers
standings.all$ROW <- standings.all$RW + standings.all$OTW
standings.all$points <- 3 * standings.all$RW + 2 * standings.all$OTW +
  2 * standings.all$SOW + 1 * standings.all$OTL + 1 * standings.all$SOL

# Ordering the dataframe by points and ROW
standings.all <- standings.all[with(standings.all, order(
	-points, -ROW
	)), ]

# Looking at standings team by team
colnames(standings.all)[2] <- 'Team'
print('Pacific Standings:')
standings.all[standings.all$Division == 'P', c('X', 'points')]
print('Central Standings:')
standings.all[standings.all$Division == 'C', c('X', 'points')]
print('Metro Standings:')
standings.all[standings.all$Division == 'M', c('X', 'points')]
print('Atlantic Standings:')
standings.all[standings.all$Division == 'A', c('X', 'points')]




