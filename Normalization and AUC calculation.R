#Libraries you need
library(openxlsx)
library(readxl)
library(writexl)
library(dplyr)

############ Individual Parameters (Change these) ##########

# set path and load data
setwd("YOUR PATH")
# dataset name (keep the extension .xlsx)
datasetname<-"Data.xlsx"
# name for figures (keep the extension .xlsx)
save.with.this.name<- "output.xlsx"
# addition (1) or subtraction (2)? 
what.should.I.do<-0
# Y-axis range you would like to have: (min,max) -> e.g c(1,2) for a 1 to 2 range
which_range<-c(0.05,2)
#Area n°1 
x1<-20        
x2<-50
#Area n°2
x3<-56
x4<-65
#Area n°3
x5<-65
x6<-76
#Area n°4
x7<-76
x8<-80
#Remove buffer's peak
f1<-0
f2<-1
f3<-2
f4<-3
# specify normalization factor
normafactor<-1.011


#################################### 
#Load
data <- read_excel(datasetname)

# replace NaN position in Fraction vector
fractionnum <- data$`Fraction Number` 
whereAreValues<-which(!is.na(fractionnum))
fromHere<-(c(0,whereAreValues))+1 
toHere<-(c(whereAreValues,(length(fractionnum))))
values<-fractionnum[!is.na(fractionnum)]
replaceWithThis<-c(values,NA)
for (i in 1:length(fromHere)) {
  row1<-fromHere[i]
    row2<-toHere[i]
  for (j in row1:row2) {
    fractionnum[j]<-replaceWithThis[i]
  }  
}
data$`Fraction Number`<-fractionnum

# to dismiss (part measured but that remains in the tubing so it can be removed)
data <- data[-which(is.na(data$`Fraction Number`)), ]

# to remove (background from buffer)
data<-data[!(data$`Fraction Number`==f1 | data$`Fraction Number`==f2 | data$`Fraction Number`==f3| data$`Fraction Number`==f4),]

# adjust (add or remove smallest value)
min<-min(data$Absorbance)

if (what.should.I.do == 1 ) {
  data$Absorbance<- data$Absorbance + min
} else {
  data$Absorbance<- data$Absorbance - min
}

# normalize (multiply "absorbance" to "normafactor")
absorbance.normalized<-data$Absorbance*normafactor
datanorm<-data
datanorm$Absorbance<-absorbance.normalized

# define and normalise y axis 
absorbance<-datanorm$Absorbance

# define x axis
mm <-datanorm$`Position(mm)`
fraction<-round(datanorm$`Fraction Number`,digits = 2)

#  X is position(mm), Y is "absorbance" with additional line
plotname1<-gsub(" ", "", paste( "Plot1_" , save.with.this.name,".pdf"))
pdf(plotname1)
plot(mm , absorbance, xlim=range(mm), ylim=range(which_range), type="l", xlab="Position (mm)", ylab="Absorbance")
par(new = TRUE)
plot(mm , absorbance, xlim=range(fraction), ylim=range(which_range), type="l", yaxt = "n",xaxt = "n", xlab="", ylab="")
axis(fraction, las=2,side = 3)
mtext("Fraction Number", side = 3, line = 3)
dev.off()


# same plot but not won´t be saved, created just for the purpose of AUC calculation
plotname2<-gsub(" ", "", paste( "Plot2_" , save.with.this.name,".pdf"))
pdf(plotname2)
plot(mm , absorbance, xlim=range(mm), ylim=range(absorbance), type="l"
     , xlab="Position (mm)", ylab="Absorbance")
dev.off()


# Variable for AUC calculation 
data <- data.frame(mm, absorbance)

#------------------------ Find AUC n #1-----------------------------------
#Reference: https://stackoverflow.com/questions/4954507/calculate-the-area-under-a-curve
#Finding values of interest
data_interest = data[data$mm >= x1 & data$mm <= x2, ]

#Computed using formula
auc <- function(data_interest){
  sum(diff(data_interest$mm) * (head(abs(data_interest$absorbance),-1)+tail(abs(data_interest$absorbance),-1)))/2
}
auc1<-auc(data_interest)

#------------------------ Find AUC n #2----------------------------------
#Finding values of interest
data_interest = data[data$mm >= x3 & data$mm <= x4, ]

#Computed using formula
auc <- function(data_interest){
  sum(diff(data_interest$mm) * (head(abs(data_interest$absorbance),-1)+tail(abs(data_interest$absorbance),-1)))/2
}
auc2<-auc(data_interest)

#------------------------ Find AUC n #3----------------------------------
#Finding values of interest
data_interest = data[data$mm >= x5 & data$mm <= x6, ]

#Computed using formula
auc <- function(data_interest){
  sum(diff(data_interest$mm) * (head(abs(data_interest$absorbance),-1)+tail(abs(data_interest$absorbance),-1)))/2
}
auc3<-auc(data_interest)

#------------------------ Find AUC n #4----------------------------------
#Finding values of interest
data_interest = data[data$mm >= x7 & data$mm <= x8, ]

#Computed using formula
auc <- function(data_interest){
  sum(diff(data_interest$mm) * (head(abs(data_interest$absorbance),-1)+tail(abs(data_interest$absorbance),-1)))/2
}
auc4<-auc(data_interest)

#------------------------ Save results----------------------------------

results<-matrix(0, nrow = 4, ncol = 3)
colnames(results) <- c("Auc", "x1", "x2")

results[1,]<-c(auc1,x1,x2)
results[2,]<-c(auc2,x3,x4)
results[3,]<-c(auc3,x5,x6)
results[4,]<-c(auc4,x7,x8)
write.xlsx(results, file= save.with.this.name, row.names=FALSE)


