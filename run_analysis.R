
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

vlabels<-as.character(features$V2) 

ttrain<-cbind(strain,atrain$V2,xtrain)
ttest<-cbind(stest,atest$V2,xtest)

ttrain <- unname(ttrain)
ttest <- unname(ttest)
names(ttrain)<-c('subject','activity',vlabels)
names(ttest)<-c('subject','activity',vlabels)

ttotal<-rbind(ttrain,ttest)
cl<-c(1,2,grep("std",tolower(names(ttotal))),grep("mean",tolower(names(ttotal))))



tidy<-ttotal[sort(cl)]

tidy1<-aggregate(tidy[3:88],by=list(subject=tidy$subject,activity=tidy$activity),mean)
write.table(tidy1,"tidy.txt",row.name=FALSE) 
