#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis <- function() {
  if(!file.exists("./data")){dir.create("./data")}
  
  #Download & unzip source file
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/data.zip")
  unzip("./data/data.zip",exdir="./data")
  
  #Load feature list
  fileName<-"./data/UCI HAR Dataset/features.txt"
  features<-read.table(fileName,sep=" ",header=FALSE,col.names=c("feature.id","feature"),colClasses=c("integer","character"))
  outFeatures<-rbind(features[grepl("mean",features$feature),],features[grepl("std",features$feature),])

  #Load train data  
  fileName<-"./data/UCI HAR Dataset/train/subject_train.txt"
  subject<-read.table(fileName,header=FALSE,col.names=c("subject.id"),colClasses="integer")
  fileName<-"./data/UCI HAR Dataset/train/y_train.txt"
  y<-read.table(fileName,header=FALSE,col.names=c("y.id"),colClasses="factor")
  fileName<-"./data/UCI HAR Dataset/train/X_train.txt"
  x<-read.fwf(fileName,rep(16,times=561),header=FALSE,colClasses="numeric",buffersize = 200)
  #Set names
  names(x)<-features$feature
  train<-cbind(subject,y,x)
  train<-train[,c(names(train)[1:2],outFeatures$feature)]

  #Load test data
  fileName<-"./data/UCI HAR Dataset/test/subject_test.txt"
  subject<-read.table(fileName,header=FALSE,col.names=c("subject.id"),colClasses="integer")
  fileName<-"./data/UCI HAR Dataset/test/y_test.txt"
  y<-read.table(fileName,header=FALSE,col.names=c("y.id"),colClasses="factor")
  fileName<-"./data/UCI HAR Dataset/test/X_test.txt"
  x<-read.fwf(fileName,rep(16,times=561),header=FALSE,colClasses="numeric",buffersize = 200)
  #Set names
  names(x)<-features$feature
  test<-cbind(subject,y,x)
  test<-test[,c(names(test)[1:2],outFeatures$feature)]

  #Merge train & test  
  result<-rbind(train,test)

  #Load activity names
  fileName<-"./data/UCI HAR Dataset/activity_labels.txt"
  activity<-read.table(fileName,header=FALSE,sep=" ",col.names=c("activity.id","activity"),colClasses=c("factor","character"))
  
  #Merge activity names with result set
  result<-merge(result,activity,by.x="y.id",by.y="activity.id",all=TRUE)
  
  #Reorder columns
  result<-result[,c(82,1:81)]

  library(reshape2)
  #Melt data by activity a subject
  resultMelt <- melt(result,id=c("activity","subject.id"),measure.vars=names(result)[4:82])
  
  #Compute mean
  result.dataset <- dcast(resultMelt, activity + subject.id ~ variable, mean)
  
  #Generate output file
  write.table(result.dataset, "./data/result_dataset.txt", sep=",", row.names = FALSE, quote=FALSE)

}