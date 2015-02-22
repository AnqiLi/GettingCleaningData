The script run_analysis.R takes in data in the UNZIPPED folder UCI HAR Dataset/
and generates the average value correspond to the mean and standard deviation
with respect to each subject, activity and measurement and save it in tidydataset.txt
library reshape2 is required for reshaping

The project was done by the following steps

1. Creating file connection for each table. This script starts with the assumption 
   that the Samsung data is available in the working directory in an unzipped UCI HAR 
   Dataset folder

2. reading tables and merging training and testing data, including training data, 
   testing data, activity labels and features with read.table()

3. merge the two data set into a whole dataset with command cbind() for merging activity,
   subjects, etc., coloumns, and rbind() for merging training and testing data set

4. selecting features indices which are means and standrad deviations with gsub, only 
   considering features with "mean()" and "std()" in their names

5. subsetting merged data set, extracting columns only contain mean and standard deviation
   measurement with vector generated in the above step

6. renaming the activity values with descriptive activity names by factorizing the column
   then change the level of the factor as "activity_labels.txt" with factor() and levels()

7. renaming the colume names with descriptive measurement names with ftr vector and ftrIdx
   which contrain the index of the features that contrain desired measurement generated in
   step 4

8. reshaping the data set to the tidy data set with reshape library and melt() and dcast()
   commands

9. saving the tidy dataset with write.table()

To test the script, run test_analysis.R in the same repo