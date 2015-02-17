# run-analysis.R

source("utilities.R")

# Read Data and Var Names -------------------------------------------------
# Merges the training and the test sets to create one data set. -----------

tab<-ReadAndMerge("UCI_HAR_Dataset")
write.table(tab,file = "_uciHarDataset_merged.txt",row.names = FALSE)
str(tab)

# Extracts mean and standard deviation for each measure -------------------

mstab<-MeanAndSigma(tab)

# Use descriptive activity names to name the activities -------------------


# Labels the data set with descriptive variable names.  -------------------


# tidy data set with the average of each variable -------------------------
# for each activity and each subject. -------------------------------------


