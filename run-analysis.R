#!/opt/local/bin/Rscript 

# run-analysis.R

# Details on the theory of operation is in README.md.
# Details on the data format this flow yields is in CodeBook.md


library(dplyr)
source("utilities.R")


# Read Data and Var Names -------------------------------------------------
# Merges the training and the test sets to create one data set.

tab<-getReadAndMerged("UCI_HAR_Dataset") 


# Filter, Average and Tidy ------------------------------------------------

tidytab<-tab %>%
    getMeanAndSigma() %>%   # Extracts mean and standard deviation for each measure
    getAveragedEach() %>%   # Average of each variable
    setTidyNames()          # Tidy data set for each activity (Activity) and subject (Feature)


# Write the file to disk for attaching to the Assignment ------------------

WriteStep5(tidytab)
