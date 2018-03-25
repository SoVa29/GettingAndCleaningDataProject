## Code book for Coursera Getting and Cleaning Data course project


The script run_analysis.R performs the 5 steps described in the course project's definition:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


* Code overview *

The similar data is merged using the rbind() function. 
By similar, we address those files having the same number of columns and referring to the same entities.
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. 
After extracting these columns, they are given the correct names, taken from features.txt.
The descriptive activity names were used to name the activities in the data set (the activity names and IDs are based on the activity_labels.txt file) and they are substituted in the dataset.
During the next step the column names are corrected.
Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

* Data *

See the README.md file of this repository for background information on this data set.

* Variables *

* x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
* xData, yData and subjectData merge the previous datasets to further analysis.
* features contains the correct names for the xData dataset, which are applied to the column names stored in columnsMeanSTD, a numeric vector used to extract the desired data.
The dataMeanSTD set contains data with only mean and standard deviation.
A similar approach is taken with activity names through the activities variable.
tidyData merges xData, yData and subjectData in a combined dataset.
The finalData contains the averages which will be later stored in a tidydata.txt file. 

* Result Data Set *

Identifiers
* subject - The ID of the test subject
* activity - The type of activity performed when the corresponding measurements were taken

Measurements
see features_info.txt file

Activity Labels

- WALKING (value 1): subject was walking during the test
- WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
- WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
- SITTING (value 4): subject was sitting during the test
- STANDING (value 5): subject was standing during the test
- LAYING (value 6): subject was laying down during the test