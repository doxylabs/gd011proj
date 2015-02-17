
# ReadAndMerge: See README.md

library(dplyr)
library(tidyr)

ReadAndMerge<-function(wd = "UCI_HAR_Dataset")
{
    if(file.access(names=wd)<0){
        message("I cannot find the working directory")
        return(-1)
    }
    oldwd<-getwd()
    setwd(wd)
    
    # Read Data and Var Names -------------------------------------------------
    
    vNames<-read.table("features.txt",stringsAsFactors = F)
    aNames<-read.table("activity_labels.txt",stringsAsFactors = F)
    
    XTrain<-read.table("train/X_train.txt",stringsAsFactors=F)
    XTest<-read.table("test/X_test.txt",stringsAsFactors=F)
    
    YTrain<-read.table("train/Y_train.txt",stringsAsFactors=F)
    YTest<-read.table("test/Y_test.txt",stringsAsFactors=F)
    
    subTrain<-read.table("train/subject_train.txt",stringsAsFactors=F)
    subTest<-read.table("test/subject_test.txt",stringsAsFactors=F)
    
    
    # Merges the training and the test sets to create one data set. -----------
    
    
    # Assign names to each variable from the features.txt names
    names(XTrain)<-vNames$V2
    names(XTest)<-vNames$V2
    
    XTrain$Activity<-sapply(YTrain$V1,function(x) as.factor(aNames[x,"V2"]))
    XTest$Activity<-sapply(YTest$V1,function(x) as.factor(aNames[x,"V2"]))
    
    # Summary data
    # table(XTrain$Y); table(XTest$Y)
    
    # Merge the tables into tab
    tab<-XTrain; tab<-rbind(tab,XTest)
    
    # Clear out unused tables
    rm(aNames,subTest,subTrain,vNames,XTest,XTrain,YTest,YTrain)
    setwd(oldwd)
    
    return(tab)
}



# MeanAndSigma(): See README.md

MeanAndSigma<-function(t)
{
    # Extracts mean and standard deviation for each measure -------------------
    # t<-tab
    table(names(t))
    woo<-t %>%
        select(Activity)
    
#     colNames<-names(t)[!(names(t) %in% c("Activity"))]
#     by(data = t,t[,colNames], mean)
#     t$Activity
#     aggregate(t, by = t$Activity, FUN = mean)
}


# Use descriptive activity names to name the activities -------------------


# Labels the data set with descriptive variable names.  -------------------


# tidy data set with the average of each variable -------------------------
# for each activity and each subject. -------------------------------------


