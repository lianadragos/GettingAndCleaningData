# GettingAndCleaningData Project
This folder contains the explanations about how the scripts work and how they are connected.
## The Transformation Script run_analysis.R

The file run_analysis.R contains an R script for transforming the original dataset into a second dataset according to the following guidelines:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

### Explanation Of The Script

The script begins by downloading and unzipping the archive containing the files with all the data. Then it reads these files into local variables.
Further more merge the test and train sets in order to create one data set of each : Activity Subject and Features. Variables names are set. The three data sets are finally bind into one data set.
Values of the Activity variable are factorized using the values from the activity_labels.txt file.
Subsequently it appropriately labels the data set with descriptive variable names
Finally the tidy data obtained is used to provide a second independent data frame which is exported as a text file (tidydata.txt) 

## The codebook. 

The codebook is contained in the file CodeBook.md. It describes the variables of the output data set and summaries used to calculate the values, along with units and any other relevant information.



