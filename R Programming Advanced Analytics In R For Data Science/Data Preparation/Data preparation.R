setwd("C:/Users/ShashankGupta(Annale/OneDrive - OneWorkplace/Desktop/Udemy/R Programming Advanced Analytics In R For Data Science/Data Preparation")
#Normal import
#fin= read.csv("P3-Future-500-The-Dataset.csv")
#Replace empty valuers with NA
fin= read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))

head(fin)
str(fin)
summary(fin)

# Changing from Non Factor to factor
fin$ID=factor(fin$ID)
fin$Inception=factor(fin$Inception)
str(fin)

# Converting into numneric for factor
y=factor(c("12","13","14", "12","12"))
typeof(y)
z=as.numeric(y)
typeof(z)

#------Correct way
x=as.numeric(as.character(y))
x

# FTV example
summary(fin)
str(fin)

# fin$Profit=factor(fin$Profit)
# fin$Profit=as.numeric(as.character(fin$Profit))
# sub () and gsub()
# ?sub
# Replace dollar siogn

fin$Expenses= gsub(" Dollars", "", fin$Expenses)

# Replace comma
fin$Expenses= gsub(",", "", fin$Expenses)
head(fin)
str(fin)

# Replace $ and ,
fin$Revenue= gsub("\\$", "", fin$Revenue)
fin$Revenue= gsub(",", "", fin$Revenue)
str(fin)
fin$Growth= gsub("%", "", fin$Growth)

# Change type to numeric(factor to character already converted by gsub)
fin$Expenses=as.numeric(fin$Expenses)
fin$Revenue=as.numeric(fin$Revenue)
fin$Growth=as.numeric(fin$Growth)
str(fin)
head(fin,24)

# Locate missing data------------------------------------------
fin[!complete.cases(fin),]

# Filtering: Using which() for non missing data.-----------------------------------------------------
head(fin)
fin[fin$Revenue==9746272,]

# Which returns the row number where vale is located so that we can remove NAs
fin[which(fin$Revenue==9746272),]
fin[which(fin$Employees==45),]
# Find null in Expenses
fin[is.na(fin$Expenses),]

# Removing record with missing data----------------------------------------------------
fin_backup=fin
# Recoed with all empty values
fin[!complete.cases(fin),]
# Missing Industury
fin[is.na(fin$Industry),]
fin=fin[!is.na(fin$Industry),]# Opposite
fin[!complete.cases(fin),]
# Reseting dataframe index
# Way 1
rownames(fin)=NULL
# Way 2
rownames(fin)=1:nrow(fin)

# Replace missing Data: Replace null States
fin[!complete.cases(fin),]
fin[is.na(fin$State),]
fin[is.na(fin$State)&fin$City=="New York",]
fin[is.na(fin$State)&fin$City=="New York","State"]="NY"
fin[is.na(fin$State)&fin$City=="San Francisco","State"]="CA"
# Check
fin[c(11,377),]
fin[c(82,265),]

#Replace missing Data: Median Imputation Method ( Part 1)
fin[!complete.cases(fin),]
med_empl_retail=median(fin[fin$Industry=="Retail","Employees"], na.rm = TRUE)
fin[is.na(fin$Employees)&fin$Industry=="Retail",]
fin[is.na(fin$Employees)&fin$Industry=="Retail","Employees"]=med_empl_retail
# Check

fin[3,]

#Replace missing Data: Median Imputation Method ( Part 1)
fin[!complete.cases(fin),]
med_empl_retail=median(fin[fin$Industry=="Financial Services","Employees"], na.rm = TRUE)
med_empl_fs=median(fin[fin$Industry=="Financial Services","Employees"], na.rm = TRUE)
med_empl_fs
fin[is.na(fin$Employees)&fin$Industry=="Financial Services",]
fin[is.na(fin$Employees)&fin$Industry=="Financial Services","Employees"]=med_empl_fs
fin[c(330),]
fin[!complete.cases(fin),]
med_empl_construction=median(fin[fin$Industry=="Construction","Growth"], na.rm = TRUE)
med_empl_construction
fin[is.na(fin$Growth)&fin$Industry=="Construction",]
fin[is.na(fin$Growth)&fin$Industry=="Construction","Growth"]=med_empl_construction
fin[c(8),]
fin[!complete.cases(fin),]
med_rev_construction=median(fin[fin$Industry=="Construction","Revenue"], na.rm = TRUE)


#Replace missing Data: Median Imputation Method ( Part 3)
fin[!complete.cases(fin),]
med_rev_construction=median(fin[fin$Industry=="Construction","Revenue"], na.rm = TRUE)
med_rev_construction
fin[is.na(fin$Revenue)&fin$Industry=="Construction",]
fin[is.na(fin$Revenue)&fin$Industry=="Construction","Revenue"]=med_rev_construction
fin[c(8,42),]
fin[!complete.cases(fin),]
med_exp_construction=median(fin[fin$Industry=="Construction","Expenses"], na.rm = TRUE)
med_exp_construction
fin[is.na(fin$Expenses)&fin$Industry=="Construction",]
fin[is.na(fin$Expenses)&fin$Industry=="Construction","Expenses"]=med_exp_construction
fin[c(8,42),]
fin[!complete.cases(fin),]
fin[is.na(fin$Expenses)&fin$Industry=="Construction"&is.na(fin$Profit),]
fin[is.na(fin$Profit),"Profit"]=fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Expenses"]
fin[c(8,42),]


# replace missing data : Derive Values
# Profit= Revenue-Expenses
# Expenses =Revenue - Profit
fin[!complete.cases(fin),]
fin[is.na(fin$Profit),"Expenses"]=fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Profit"]
fin[c(15),]
fin[is.na(fin$Expenses),"Expenses"]=fin[is.na(fin$Expenses),"Revenue"]-fin[is.na(fin$Expenses),"Profit"]
fin[c(15),]
fin[!complete.cases(fin),]
# Visualization
library(ggplot2)
p=ggplot(data=fin)
typeof(p)
p+geom_point(aes(x=Revenue, y=Expenses))
p+geom_point(aes(x=Revenue, y=Expenses, colour=Industry))
p+geom_point(aes(x=Revenue, y=Expenses, colour=Industry,size=Profit))
# • A scatterplot that includes industry trends for the expenses~revenue relationship

d=ggplot(data=fin,aes(x=Revenue, y=Expenses, colour=Industry) )
d+geom_point()+geom_smooth()
d+geom_point()+geom_smooth(fill=NA, size=1.2)
f=ggplot(data=fin,aes(x=Industry, y=Growth, colour=Industry) )
f+geom_boxplot()+
  geom_boxplot(size=1, alpha=0.5)
# Extra
f+geom_jitter()+
geom_boxplot(size=1, alpha=0.5)
# Extra
f+geom_jitter()+
  geom_boxplot(size=1, alpha=0.5)
# Extra
f+geom_jitter()+
  geom_boxplot(size=1, alpha=0.5,outlier.colour = NA)
