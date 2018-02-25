# CodeBook.md for run_analysis.R

## run_analysis.R

This script contains the function:  run_analysis(parent_path)

## Purpose
To merge the training and test data sets from the experiment and to product a tidy data set that can be used for later analysis.

## The Process for Data Transformation
These summarise the process steps implemented in the run_analysis.R script:

1. Validate the parent_path to ensure it contains both train and test sub paths and the features and activity_labels text files.
2. The features.txt and activity_labels.txt files are read and will be used to label the activity and the measurements in the test and train data files.
3. A vector containing TRUE or FALSE is created from the features.txt file which will be used to identify columns for the mean and standard deviation measurement names.
4. Another vector is created containing the mean and standard deviation measurement names.
5. The function uses a 'for' loop to iterate between the test and train sub folders.
6. In the first loop, the function reads the files subject_test, X_test and y_test and the data columns are merged.
7. In the next loop, the function reads the files subject_train, X_train and y_train and the data columns are merged and these entire data set is appended to the 'test' data.
8. The data frame is then converted to a tall data with subject, activity, measurement and measurement_mean columns. The measurement column contains the names of the measurement columns from the original data set.  The measurement_mean column contains the mean of each of the measurement columns.

## The Variables
<b>parent_path</b> is the path which contains the following:
* <b>'test'</b> and <b>'train'</b> folders which contain the experiment results
* <b>'activity_labels.txt'</b> which contain the activity id and activity names
* <b>'features.txt'</b> which contain the names of the measurements

<b>activity_labels</b> is a data table containing the data from the activity_labels.txt file.

<b>features</b> is a data table containing the data from teh features.txt file.

<b>features_mean_sd_colfilter</b> is a vector containing TRUE or FALSE.  TRUE if the measurement name contains either 'mean( or 'std('.  This is used to identify the columns for the measurements for the mean and standard deviation. Note, the grepl expression includes the open parenthesis '(' to ensure that measurements are for mean and std (standard deviation) only.

<b>features_mean_sd_colnames</b> is a vector containing the names of the measurements for the mean and standard deviations.

<b>dataset_partitions</b> is a vector containing 'test' or 'train' and is used in the 'for' loop.

<b>dataset_partition</b> is a either a 'test' or 'train' and is used in the 'for' loop to identify the sub folder containing the test or train data sets.

<b>dataset_path</b> is the path containing the measurements files that are prefixed with subject_, X_, y_ .

<b>dataset_file_path</b> is the full path to the measurement file. 

<b>dataset_table</b> is a temporary data table for which the subject_, X_, and y_ files will be merged into.

<b>dataset_X_table</b> is a temporary data table containing test or training (X_) data set.

<b>master_table</b> is a temporary data table which will contain the merged 'test' and 'train' data set.

<b>tidy_table</b> will contain the tidy data set.

### Returns
A tidy data set is returned with four columns:
* <b>subject</b> - the id for the subject that performed the activity
* <b>activity</b> - the name of the activity performed by the subject
* <b>measurement</b> - the measurement for the activity which is either the mean or standard deviation for the measurement
* <b>measurement_mean</b> - the mean of the measurements' mean or standard deviation

## The Data
The run_analysis function will obtain the following files in the specific folder:

* <b>parent_path</b> folder:
  
  * <b>'activity_labels.txt'</b> which contain the activity id and activity names
  
  * <b>'features.txt'</b> which contain the names of the measurements
  
* <b>parent_path/train</b> and <b>parent_path/test</b> sub folders:
  
  * <b>'subject_train.txt'</b> and <b>'subject_test.txt'</b>: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
  * <b>'X_train.txt'</b> and <b>'X_test.txt'</b>: Each row contains the training or test measurements. Each column corresponds to a measurement name in the features.txt file. Only the mean and standard deviation for each measurement is obtained in this run_analysis code.
  * <b>'y_train.txt'</b> and <b>'y_test.txt'</b>: Each row contains the ID of the activity performed. These IDs correspond to an activity name in the activity_labels.txt file.

## How to use the run_analysis function

1. Ensure the parent_path folder contains the 'test' and 'train' sub folders, activity_labels.txt and features.txt.
2. Run the 'run_analysis' function and passing the parent_path as the parameter.
3. The function will return a tidy data data frame.

End.
