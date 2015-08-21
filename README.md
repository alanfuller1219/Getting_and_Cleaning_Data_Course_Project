Getting_and_Cleaning_Data_Course_Project

This repository is for the Coursera Getting and Cleaning Data course project.  

This repository includes
•	This readme file
•	An R script, run_analysis.R
•	A tidy data file, tidy_output.txt
•	A code book, CodeBook.md

Code Book

The code book provides information about the data used in the analysis, including a description of the variables, the data, and any transformations or work performed to clean up the data.

Tidy Data File

The tidy data file is a data set that could be used for further analysis of the data.  It meets requirement 5 in the course project, and is also attached directly to the Coursera page.

R Script

The R script, run_analysis.R, is further described below.  There is only a single script.
Documentation is included in the script to provide details of what is happening at each step.  All of the steps in the project assignment are completed, but not in the exact order as given.   
The script has the following steps:
     1.	 Loads the libraries needed.
     2.	Reference code used to download the files and unzip them is provided for reference, although not technically required.
     3.	The working directory is set to be the directory with the zip files
     4.	Data is read in
     5.	The features table, which includes the list of variable names, is cleaned up in a variety of ways.  This creates descriptive, more read-able variable names.  Special characters such as parens, commas, and dashes are removed, abbreviations are expanded, and a typo is fixed.  Index numbers are added, to make the names unique.
     6.	Column names are applied to all data sets, including the cleaned up variable names for the main data sets.
     7.	The mean and std columns are selected.  There were some columns that included the word “mean” in the title, but are not actually measurements of an activity mean, as given in the codebook that comes with the data.  I refer to these columns as the “angle” and “meanfreq” columns.  I chose not to include these columns based on the directions given in the assignment.  There were 66 variables selected.  
     8.	The index numbers are removed to make the labels more tidy and because the summarize function doesn't like the numbers in the variable names for some reason.
     9.	The various parts of the test and training test data sets are combined.  This yields a complete set of data for test subjects and a complete set of data for training subjects.  
     10.	A column was added to track the sample type for each record (test or training)
     11.	The activity labels are merged onto the data sets for test and training records to provide descriptive activity names.
     12.	The columns are re-ordered and the redundant activity_id column is dropped.
     13.	The test and training data sets are combined to create a single tidy data set with all of the data.  

At this point, the script has completed each of the first four requirements:

•  Merges the training and the test sets to create one data set. 
•  Extracts only the measurements on the mean and standard deviation for each measurement.  
•  Uses descriptive activity names to name the activities in the data set 
•  Appropriately labels the data set with descriptive variable names.


The last requirement requires some additional steps.  The requirement is:
•   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I prefer the “long” version of the tidy data set, which requires some additional steps.
     1.	Gather the variable columns using the tidyr gather() function.
     2.	Group the data
     3.	Use the summarize() function to take the mean of all measures
     4.	Write a txt table to be submitted
