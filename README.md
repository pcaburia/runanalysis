# runanalysis

This repository contain the run_analysis.R file and the data files that were captured from Human Activity Recognition Using Smartphones Dataset experiment.

## run_analysis.R

This script contains the function:  run_analysis(parent_path)

### Purpose
To merge the training and test data sets from the experiment and to product a tidy data set that can be used for later analysis.

### Parameters
<b>parent_path</b> is the path which contains the following:
* <b>'test'</b> and <b>'train'</b> folders which contain the experiment results
* <b>'activity_labels.txt'</b> which contain the activity id and activity names
* <b>'features.txt'</b> which contain the names of the measurements

### Returns
A tidy data as a data frame is returned with four columns:
* <b>subject</b> - the id for the subject that performed the activity
* <b>activity</b> - the name of the activity performed by the subject
* <b>measurement</b> - the measurement for the activity which is either the mean or standard deviation for the measurement
* <b>measurement_mean</b> - the mean of the measurements' mean or standard deviation

## How to use the run_analysis function

1. Ensure the parent_path folder contains the 'test' and 'train' sub folders, activity_labels.txt and features.txt.
2. Run the 'run_analysis' function and passing the parent_path as the parameter.
3. The function will return a tidy data data frame.

## Additional Notes

The run_analysis function will obtain the following files in the specific folder:

* <b>parent_path</b> folder:
  
  * <b>'activity_labels.txt'</b> which contain the activity id and activity names
  
  * <b>'features.txt'</b> which contain the names of the measurements
  
* <b>parent_path/train</b> and <b>parent_path/test</b> sub folders:
  
  * <b>'subject_train.txt'</b> and <b>'subject_test.txt'</b>: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
  * <b>'X_train.txt'</b> and <b>'X_test.txt'</b>: Each row contains the training or test measurements. Each column corresponds to a measurement name in the features.txt file.
  * <b>'y_train.txt'</b> and <b>'y_test.txt'</b>: Each row contains the ID of the activity performed. These IDs correspond to an activity name in the activity_labels.txt file.

End.
