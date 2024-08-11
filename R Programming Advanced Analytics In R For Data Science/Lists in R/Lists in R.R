# Deliverables

# Character: Machine name
# Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
# Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
# Vector: All hours where utilisation is unknown (NA’s)
# Dataframe: For this machine
# Plot: For all machines

getwd()
setwd("C:/Users/ShashankGupta(Annale/OneDrive - OneWorkplace/Desktop/Udemy/R Programming Advanced Analytics In R For Data Science/Lists in R")

#Normal import

#Replace empty valuers with NA
util= read.csv("P3-Machine-Utilization.csv")


head(util,12)
str(util)
summary(util)
# Derive Utilization Column

util$Utilization=1-util$Percent.Idle
util$ PosixTime=as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util,12)
summary(util)

# Re arrange columns 
util$Timestamp=NULL
util=util[,c(4,1,2,3)]
head(util,12)

# What is a list
RL1=util[util$Machine=="RL1",]
summary(RL1)
RL1$Machine=factor(RL1$Machine)
summary(RL1)

# Construct List

# Character: Machine name
# Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
# Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
util_stats_rl1=c(min(util$Utilization, na.rm = TRUE),
                 mean(util$Utilization, na.rm = TRUE),
                 max(util$Utilization, na.rm = TRUE))
util_stats_rl1

util_under_90_flag=length(which(util$Utilization<0.90))>0
util_under_90_flag

list_rl1=list("RL1",util_stats_rl1,util_under_90_flag)

# Naming Components of list
names(list_rl1)
names(list_rl1)= c("Machine", "Stats", "LowThreshold")
names(list_rl1)

# Another way like with dataframe
rm(list_rl1)
list_rl1=list(Machine="RL1",Stats=util_stats_rl1,LowThreshold=util_under_90_flag)

# Extract components of a list , 3 ways
# []- Will always return the list
# [[]]- Will return the actual object
# $- will return same as [[]] but prettier

list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
typeof(list_rl1[2])
list_rl1[[2]]
typeof(list_rl1[[2]])
list_rl1$Stats
typeof(list_rl1$Stats)

# Adding and Deleting list component
list_rl1[4]<- "New Information"
# Another way to add via $ sign 
# We will add
# Vector: All hours where utilisation is unknown (NA’s)
list_rl1$UnknownHours= RL1[is.na(RL1$Utilization),"PosixTime"]

# Remove a component, notice numeration has shifted
list_rl1[4]=NULL

# Add another component
# Dataframe: For this machine
list_rl1$Data<-RL1
list_rl1
str(list_rl1)

# Subsetting a list
list_rl1[1]
list_rl1[1:3]
list_rl1[c(1,4)]
list_rl1[c("Machine","Stats")]

# Plot: For all machines
# Building a timeseries plot
library(ggplot2)
p=ggplot(data=util)
my_plot<- p+geom_line(aes(x=PosixTime,y=Utilization,color=Machine),size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.90, color="Gray", size=1.2, linetype=3)

list_rl1$Plot=my_plot

summary(list_rl1)
str(list_rl1)
