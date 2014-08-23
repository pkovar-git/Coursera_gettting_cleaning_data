Coursera - gettting & cleaning data
===================================

##Assignment description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


##Solution

Follow these steps to get result tidy dataset.

* Put enlosed run_analysis.R script into your R working directory.
* Load the script source('run_analysis.R')
* Execute run_analysis() function
* The script creates ./data directory in R working directory, downloads source data and unzips it.
* If you don't have internet conectivity put mentioned zip file manually into working directory.
* You will find output result_dataset.txt file in working directory after the script is finished.

Package which have to be installed: reshape2,plyr
