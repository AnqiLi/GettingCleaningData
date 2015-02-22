## This script run_analysis.R takes in data in the UNZIPPED folder UCI HAR Dataset/
## and generates the average value correspond to the mean and standard deviation
## with respect to each subject, activity and measurement and save it in tidydataset.txt

# loading library for reshaping
library(reshape2)

# creating file connection for each table
trnDtFhd<-"./UCI HAR Dataset/train/X_train.txt"
trnAcFhd<-"./UCI HAR Dataset/train/y_train.txt"
trnSbFhd<-"./UCI HAR Dataset/train/subject_train.txt"
tstDtFhd<-"./UCI HAR Dataset/test/X_test.txt"
tstAcFhd<-"./UCI HAR Dataset/test/y_test.txt"
tstSbFhd<-"./UCI HAR Dataset/test/subject_test.txt"
ftrFhd<-"./UCI HAR Dataset/features.txt"
ActFhd<-"./UCI HAR Dataset/activity_labels.txt"

# reading tables and merging training and testing data
trnDt<-read.table(trnDtFhd,quote = "")
trnAc<-read.table(trnAcFhd,quote = "")
trnSb<-read.table(trnSbFhd,quote = "")
trnDt<-cbind(trnSb,trnAc,trnDt)
tstDt<-read.table(tstDtFhd,quote = "")
tstAc<-read.table(tstAcFhd,quote = "")
tstSb<-read.table(tstSbFhd,quote = "")
tstDt<-cbind(tstSb,tstAc,tstDt)
mrgDt<-rbind(trnDt,tstDt)

# selecting features which are means and standrad deviations and subsetting the set
ftr<-read.table(ftrFhd,quote="",stringsAsFactors = FALSE)[,2]
ftrIdx<-sort(c(grep('mean\\(\\)',ftr),grep('std\\(\\)',ftr)))
ftr<-gsub("[[:punct:]]","",ftr)
subIdx<-c(1,2,ftrIdx+2)
mrgDt<-mrgDt[,subIdx]

# renaming the activity values with descriptive activity names
ActLbl<-read.table(ActFhd,quote = "")[,2]
mrgDt[,2]<-factor(mrgDt[,2])
levels(mrgDt[,2]) <- ActLbl

# renaming the colume names with descriptive measurement names
mrgNms<-c("Subject","Activity",ftr[ftrIdx])
names(mrgDt)<-mrgNms

# reshaping the data set to the tidy data set
dtMlt<-melt(mrgDt,id=c("Subject","Activity"),measure.vars = mrgNms[c(-1,-2)])
tdySt<-dcast(dtMlt,...~variable,mean)

# saving the tidy dataset
write.table(tdySt,"tidydataset.txt", row.name=FALSE)