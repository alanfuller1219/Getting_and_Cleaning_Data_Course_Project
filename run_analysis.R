## This R file is for the Course Project of the Getting and Cleaning Data Course.
## August, 2015

##load the dplyr package and the tidyr package (assumes packages already installed)
library(dplyr)
library(tidyr)

## Please note that these first steps are for reference only.
## They download and unzip the files
## 
##Download the data and unzip the files in the working directory##
## getwd()
## fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(url=fileURL1, destfile="FUCI_HAR_Dataset.zip",mode="wb")
## unzip ("FUCI_HAR_Dataset.zip")

##Re-set the working directory to be the top folder from the unzipped data set

if(!file.exists("./UCI HAR Dataset")){dir.create("./UCI HAR Dataset")}
setwd( "./UCI HAR Dataset")


##Read in the test, train, activity, and features files, as requested in the assignment
features <-read.table(file="features.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
activity_labels <-read.table(file="activity_labels.txt", header = FALSE, sep = "")
subject_test <- read.table(file="./test/subject_test.txt", header = FALSE, sep = "")
x_test <- read.table(file="./test/X_test.txt", header = FALSE, sep = "")
y_test <- read.table(file="./test/Y_test.txt", header = FALSE, sep = "")
subject_train <- read.table(file="./train/subject_train.txt", header = FALSE, sep = "")
x_train <- read.table(file="./train/X_train.txt", header = FALSE, sep = "")
y_train <- read.table(file="./train/Y_train.txt", header = FALSE, sep = "")


## According to the information given, the Features table contains the variable names for 
## the test and train data sets. 
## Clean up the variable names in Features by removing special characters parens, commas, and dash,
## by expanding Acc to Accelerator, Gyro to Gyroscope, Mag to Magnitude, leading t to time and 
## leading f to freq.  Fix a label error the "BodyBody" .
## Also make the names unique by including the index number with each column name.

colnames(features) <-c("ID","measure")
features_good <- features %>% 
     mutate(measure2=gsub("\\(\\)","",measure)) %>% 
     mutate(measure3=gsub(",","",measure2)) %>% 
     mutate(measure4=gsub("Acc","Accelerometer",measure3)) %>%
     mutate(measure5=gsub("Gyro","Gyroscope",measure4)) %>%
     mutate(measure6=gsub("Mag","Magnitude",measure5)) %>%
     mutate(measure7=gsub("BodyBody","Body",measure6)) %>%
     mutate(measure8=gsub("^t","time",measure7))%>%
     mutate(measure9=gsub("^f","freq",measure8))%>%
     mutate(measure10=gsub("-","_",measure9)) %>% 
     mutate(measure11=paste(ID,measure10,sep="_")) %>% 
     select(measure11)


## Add unique column names to the test and train datasets.  Note that this step could be done later,
## but I find it convenient to fix the column names prior to snapping the data sets together.
colnames(x_test) <- features_good$measure11
colnames(x_train) <- features_good$measure11
colnames(y_test) <- "activity_id"
colnames(y_train) <- "activity_id"
colnames(subject_test) <- "subject_num"
colnames(subject_train) <- "subject_num"

## add column labels to the activity data set

colnames(activity_labels)  <- c("activity_id","activity_name")



##select the mean and std columns.  Exclude the columns that use the mean in calculating
## an angle or that are referring to the mean frequency.  Exclude the activity_id column, as it 
## is now redundant with activity_name.
x_test2 <-select(x_test, contains("mean"),contains("std"),-contains("angle"), -contains("meanFreq"))
x_train2 <-select(x_train, contains("mean"),contains("std"),-contains("angle"), -contains("meanFreq"))


## Remove the index numbers from the variable names

good_var_name <-as.data.frame(colnames(x_test2))
colnames(good_var_name) <- "var_labels"
good_var_name2 <-  mutate(good_var_name,var_labels2=gsub("^[0-9]*_","",var_labels)) 

colnames(x_test2) <-good_var_name2$var_labels2
colnames(x_train2) <-good_var_name2$var_labels2


##combine x_test2, y_test, and subject_test and then x_train2, y_train, and subject_train.  Note that it is important to do this
##prior to merging on the activity labels, because that merge re-orders the data.
test2 <-cbind(y_test,x_test2,subject_test)
train2 <-cbind(y_train,x_train2, subject_train)


##add a column to track the sample type in each data set
test2 <-mutate(test2,sample_type="test")
train2 <-mutate(train2,sample_type="train")

##merge the descriptive activity labels onto the test and train tables
test2 <- merge(test2,activity_labels,by.x="activity_id",by.y ="activity_id",all.x=TRUE )
train2<- merge(train2,activity_labels,by.x="activity_id",by.y ="activity_id",all.x=TRUE )

## for reference
## colnames(test2)


##re-order the columns and drop the activity_id column, as it is now redundant.
test3 <-select(test2, subject_num, sample_type, activity_name, (timeBodyAccelerometer_mean_X:freqBodyGyroscopeJerkMagnitude_std))
train3 <-select(train2, subject_num, sample_type, activity_name,(timeBodyAccelerometer_mean_X:freqBodyGyroscopeJerkMagnitude_std))

##combine the test and train data sets
all_data <- rbind(test3, train3)


## The all_data data set above completes the first 4 requirements of the assignment,
## Note that I didn't do them in the exact order given. :)
## For step 5, creating a second tidy data set with the means of each variable,
## I personally prefer the "long" version of the tidy data set.  So, I need to "melt"
## or in tidyr terms "gather" the variables together

##create the long form of the data by gathering the variables together
all_data2 <-gather(all_data, variables, measures, 
                   timeBodyAccelerometer_mean_X:freqBodyGyroscopeJerkMagnitude_std,
                   -subject_num,-sample_type, -activity_name)


##group the data, then use summarize to take the means of the measures.
tidy1 <- group_by(all_data2,subject_num,sample_type,activity_name,variables)
tidy2 <-summarize(tidy1,mean(measures))

## write the long form of the tidy table as required in step 5
write.table(tidy2,file="tidy_output.txt",row.name=FALSE)

