---
title: "CodeBook"
author: "Alan"
date: "August 21, 2015"
output: html_document
---

This is the Code Book for the Course Project of the Getting and Cleaning Data Coursera Course.  The paragraph below is copied from the Coursera Course Project by way of introduction:

Project Intro from Coursera:
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Important information is provided about the data in the link above.  The key paragraphs from the above website are copied here for quick reference:

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link]

Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

_________________________________End of material copied from the website_____________________


The run_analysis.R script in the repo consolidates and then subsets the above data and transforms it for further analysis as described in detail in the README file, which is included here by reference. The output is a data set "tidy_output.txt"", the first few lines of which are below:  


"subject_num" "sample_type" "activity_name" "variables" "mean(measures)"
1 "train" "LAYING" "timeBodyAccelerometer_mean_X" 0.22159824394
1 "train" "LAYING" "timeBodyAccelerometer_mean_Y" -0.0405139534294
1 "train" "LAYING" "timeBodyAccelerometer_mean_Z" -0.11320355358
1 "train" "LAYING" "timeGravityAccelerometer_mean_X" -0.24888179828
1 "train" "LAYING" "timeGravityAccelerometer_mean_Y" 0.70554977346
1 "train" "LAYING" "timeGravityAccelerometer_mean_Z" 0.4458177198
1 "train" "LAYING" "timeBodyAccelerometerJerk_mean_X" 0.0810865342
1 "train" "LAYING" "timeBodyAccelerometerJerk_mean_Y" 0.0038382040088
1 "train" "LAYING" "timeBodyAccelerometerJerk_mean_Z" 0.010834236361

The columns in this data set are as follows:

subject_num:  There were 30 participants or subjects in the study.  This column is an integer from 1 to      30 giving the number of the test subject. 
sample_type:  The subjects were split into test and training groups.  This is a factor variable           designating which group the subject belonged to, "test" or "train".
activity_name:  Each subject did six activities during which the smartphone measurements were taken.       The six activities are:   WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.     This column holds the activity names.
variables:  As the README explains, from the initial set of over 500 measurements taken, the data was      subset to include only 66 measurement variables including the "mean" and "std" variables.  This         column provides the variable names for each measurement variable.
mean(measures):  The mean (or average) of each of the 66 variables was taken for each combination of      subject and activity.  This column holds the mean values.

The length of the dataset is 30 subjects x 6 activities x 66 variable measurements= 11,880 rows.  

To read the data into R, use the following code, assuming the tidy_output.txt file is in the R home  directory.

tidy <-read.table(file="tidy_output.txt",header=TRUE, sep=" ")

This is a tidy data set with each variable in one column, and each different observation of that variable in a different row.  Note that it is the long form of the tidy data set.

The Course TA David Hood provided extremely valuable guidance in the course Discussion Forums, which was used in the completion of the assignment and these files.  Many thanks to other course members and course TAs who provided interesting tips and discussion.    
