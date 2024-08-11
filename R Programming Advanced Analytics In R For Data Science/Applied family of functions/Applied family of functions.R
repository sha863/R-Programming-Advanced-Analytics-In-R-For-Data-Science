# You are working on a project for a meteorology bureau. You have been supplied weather data for 4 cities in the US: 
# Chicago, NewYork, Houston and SanFrancisco. You are required to deliver the following outputs: 
# 1. A table showing the annual averages of each observed metric for every city 
# 2. A table showing by how much temperature fluctuates each month from min to max (in %). Take min temperature as the base 
# 3. A table showing the annual maximums of each observed metric for every city 
# 4. A table showing the annual minimums of each observed metric for every city 
# 5. A table showing in which months the annual maximums of each metric were observed in every city (Advanced)

getwd()
setwd("C:/Users/ShashankGupta(Annale/OneDrive - OneWorkplace/Desktop/Udemy/R Programming Advanced Analytics In R For Data Science/Applied family of functions/P3-Weather-Data/Weather Data")

#Read data
cg=read.csv("Chicago-F.csv", row.names = 1)
cg

ny=read.csv("NewYork-F.csv", row.names = 1)
hn=read.csv("Houston-F.csv", row.names = 1)
sf=read.csv("SanFrancisco-F.csv", row.names = 1)
# Check
cg
ny
hn
sf
# Thes are dataframe
is.data.frame(cg)
# Lets convert to matrices
cg=as.matrix(cg)
ny=as.matrix(ny)
hn=as.matrix(hn)
sf=as.matrix(sf)

# Let's put all of these into a list
weather= list(Chicago=cg,NewYork=ny,Houston=hn,SanFrancisco=sf)

# Apply
apply(cg,1,mean)
# Check
mean(cg["DaysWithPrecip",])

# Analyze one city
apply(cg,1,min)
apply(cg,1,max)

# Compare
apply(cg,1,mean)
apply(ny,1,mean)
apply(hn,1,mean)
apply(sf,1,mean)#combine all 4 with  c bind nearly Deliverable 1 but there is a faster way

# Recreating apply function with loops(Advanced topic)
cg
# Find the mean of every row by loop
output=NULL # Prep empty vector
for(i in 1:5){ # run cycle
  output[i]=mean(cg[i,])
}
output # lets see what we have
names(output)=rownames(cg)
output

#using Apply
apply(cg,1,mean)

# Using lApply()

# Example 1
?lapply
lapply(weather,t) # Transpose each element of list

# Example 2
rbind(cg, NewRow=1:12)
lapply(weather, rbind,NewRow=1:12)

# Example 3
# rowMeans, rowSums, colMeans, colSums
rowMeans(cg) # Similar to apply(cg,1,mean)
lapply(weather, rowMeans) # nearly Deliverable 1 even better, but we will improve further

# Combining lapply with [] operator
weather[[1]][1,1]
lapply(weather,"[",1,1) # Chicago 1st element
lapply(weather,"[",1,) # Fist element of list components
lapply(weather,"[", ,3) # 3rd column of list components

# Adding your own functions
lapply(weather,rowMeans)
lapply(weather,function(x) x[1,])# Fist element of list components
lapply(weather,function(x) x[5,])# fifth element of list components
lapply(weather,function(x) x[,12])# 12th column of each component
lapply(weather,function(z) z[1,]-z[2,]) # Diff in high and low of each list component
lapply(weather,function(z) round((z[1,]-z[2,])/z[2,],2)) # % Diff (Deliverable 2) temp fluctations but will improve 

# ??Sapply
# Avg hifg temp for july 
weather
lapply(weather, "[",1,7)
sapply(weather, "[",1,7)

# Avg high temp for 4th quarter
lapply(weather, "[",1,10:12)
sapply(weather, "[",1,10:12)

# Delivearble 1 and 2
lapply(weather, rowMeans)
round(sapply(weather, rowMeans),2) # Perfect Output
sapply(weather,function(z) round((z[1,]-z[2,])/z[2,],2))#Perfect Output

# Same as lapply
sapply(weather, rowMeans, simplify=FALSE)

# nesting apply functions
weather
apply(cg,1,max)
lapply(weather,apply ,1, max) # preferred approach
lapply(weather, function(x) apply(x,1,max))


# Deliverable 3 and 4
sapply(weather,apply ,1, max)
sapply(weather,apply ,1, min)

# Very Advanced tutorial
# Which max
?which.max
which.max(cg[1,])
names(which.max(cg[1,]))

# by the sounds of it
# We will have apply: to iterate over rows of the matrix
# We will have ; lapply or sapply to iterate over components of list
apply(cg,1,function(x) names(which.max(x)))
lapply(weather,function(y) apply(y,1,function(x) names(which.max(x))) )
sapply(weather,function(y) apply(y,1,function(x) names(which.max(x))) )
