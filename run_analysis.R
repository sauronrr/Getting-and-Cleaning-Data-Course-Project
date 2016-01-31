#read files
activity<-read.table("UCI HAR Dataset/activity_labels.txt",sep = "",header = FALSE)
features<-read.table("UCI HAR Dataset/features.txt",sep = "",header = FALSE)
xtest<-read.table("UCI HAR Dataset/test/X_test.txt",sep = "",header = FALSE)
ytest<-read.table("UCI HAR Dataset/test/y_test.txt",sep = "",header = FALSE)
atest<-merge(ytest,activity, by="V1")
stest<-read.table("UCI HAR Dataset/test/subject_test.txt",sep = "",header = FALSE)

xtrain<-read.table("UCI HAR Dataset/train/X_train.txt",sep = "",header = FALSE)
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt",sep = "",header = FALSE)
atrain<-merge(ytrain,activity, by="V1")
strain<-read.table("UCI HAR Dataset/train/subject_train.txt",sep = "",header = FALSE)

#Extrac Labels for the columns names  
vlabels<-as.character(features$V2) 

#merge subject, activity, data
ttrain<-cbind(strain,atrain$V2,xtrain)
ttest<-cbind(stest,atest$V2,xtest)

ttrain <- unname(ttrain)
ttest <- unname(ttest)
names(ttrain)<-c('subject','activity',vlabels)
names(ttest)<-c('subject','activity',vlabels)

#joint data_frame train and test
ttotal<-rbind(ttrain,ttest)
#select subject, activity, std columns and mean columns
cl<-c(1,2,grep("std",tolower(names(ttotal))),grep("mean",tolower(names(ttotal))))


#sort columns in original order
tidy<-ttotal[sort(cl)]

# get the mean values for each subject/activity
tidy1<-aggregate(tidy[3:88],by=list(subject=tidy$subject,activity=tidy$activity),mean)
# Write data_frame into a file.
write.table(tidy1,"tidy.txt",row.name=FALSE) 
