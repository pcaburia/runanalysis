
# PURPOSE: To prepare tidy data that can be used for later analysis.
# PARAMS : parent_path is the path which contains the test and train folders.
# RETURNS: a tidy data as a data frame.
# NOTES  : The data files (subject, X, and y) for the train and test data set are merged into one data frame.
#          Then a tidy data set is created from the merged data.
run_analysis <- function(parent_path) {
    
    # Ensure folder contains both train and test sub paths and the features and activity_labels text files.
    if (sum(list.files(parent_path) %in% c("test","train","features.txt","activity_labels.txt")) == 4) {
        
        activity_labels <- read.table(paste(sep = "/", parent_path, "activity_labels.txt"), header = FALSE)
        names(activity_labels) <- c("activity_id", "activity")
        
        features <- read.table(paste(sep = "/", parent_path, "features.txt"), header = FALSE)
        
        # Create the column filter to select only the mean and sd columns.
        features_mean_sd_colfilter <- grepl(pattern = "mean\\(|std\\(", x = features[,2])
        
        # Create the column names vector containing only the names of the mean and sd columns.
        features_mean_sd_colnames <- features[features_mean_sd_colfilter, 2]
        
        # --- Process the measurements data sets ---
        dataset_partitions = c("test", "train")
        
        # Process the data sets.
        for (dataset_partition in dataset_partitions) {
            
            print("*****")
            print(paste("Processing", dataset_partition, "data set."))
            
            # Create the dataset path.
            dataset_path <- paste(sep = "/", parent_path, dataset_partition)
            
            print("Create data frame with subject.")
            
            # Create the temp data frame using the "subject" dataset and update the column name
            dataset_file_path <- paste(sep = "", dataset_path, "/subject_", dataset_partition, ".txt")
            dataset_table <- read.table(dataset_file_path, header = FALSE)
            names(dataset_table) <- "subject"
            
            print(paste("CBind activity IDs for", length(dataset_table[,1]), dataset_partition, "records."))
            
            # cbind the activity IDs
            dataset_file_path <- paste(sep = "", dataset_path, "/y_", dataset_partition, ".txt")
            dataset_table <- cbind(dataset_table, read.table(dataset_file_path, header = FALSE))
            names(dataset_table)[length(dataset_table)] <- "activity_id"
            
            print("Merge activity labels.")
            
            # Merge the activity labels
            dataset_table <- merge(x = activity_labels, y = dataset_table, by.x = "activity_id", by.y = "activity_id")
            
            print(paste("Create temp data frame for", dataset_partition, " dataset."))
            
            # Obtain the test or training (X_) data set and put into a temp data table
            dataset_file_path <- paste(sep = "", dataset_path, "/X_", dataset_partition, ".txt")
            dataset_X_table <- read.table(dataset_file_path, header = FALSE)[, features_mean_sd_colfilter]
            names(dataset_X_table) <- features_mean_sd_colnames
            
            print("CBind temp to master data frame")
            
            # cbind the temp data frame to the master data frame.
            dataset_table <- cbind(dataset_table, dataset_X_table)
            
            if (dataset_partition == "test") {
                master_table <- dataset_table
            } else {
                master_table <- rbind(master_table, dataset_table)
            }
        }
        
        print("*****")
        print("Generating tidy data.")
        
        tidy_table <-  master_table %>%
                        gather(measurement, measurement_value, -activity_id, -activity, -subject) %>% 
                            group_by(subject, activity, measurement) %>%
                                summarize(measurement_mean = mean(measurement_value))
        
        print("Tidy Data Generated")
        tidy_table
    }
}