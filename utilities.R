# utilities.R
# See the README for more information on the functions contained herein.


library(dplyr)
library(tidyr)


getFeatures<-function(wd = "UCI_HAR_Dataset")
{
    # wd<-"UCI_HAR_Dataset"
    tab<-read.table(file.path(wd,"features.txt"),stringsAsFactors = F)
    tab$V2<-paste("id",tab$V1,tab$V2,sep = "_")
    return(tab)
}


getActivities<-function(wd = "UCI_HAR_Dataset")
{
    tab<-read.table(file.path(wd,"activity_labels.txt"),stringsAsFactors = F)
    return(tab)
}


setTidyNames<-function(tab)
{
    tab$Feature <- sapply(tab$Feature, function(x) gsub("tGravity","Gravity ",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("tBody","Body ",x) )
    
    tab$Feature <- sapply(tab$Feature, function(x) gsub("GyroJerkMag","Angular Velocity Jerk Magnitude ",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("AccJerkMag","Linear Acceleration Jerk Magnitude ",x) )
    
    tab$Feature <- sapply(tab$Feature, function(x) gsub("AccMag","Linear Acceleration Magnitude ",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("GyroMag","Angular Velocity Magnitude ",x) )

    tab$Feature <- sapply(tab$Feature, function(x) gsub("-mean()","Mean",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("-std()","Sigma",x) )

    return(tab)

}

getMeanAndSigma<-function(tab)
{
    # test
    # tab<-ReadAndMerge()
    # Extracts mean and standard deviation for each measure -------------------
    t<-tbl_df(tab)
    
    return(
        as.data.frame(
            t %>% 
                select(Activity,
                       ends_with("mean()"),
                       ends_with("std()"),
                       -contains("_f",ignore.case = FALSE),
                       -matches("meanFreq|stdFreq")
                )
        )
    )
}


getAveragedEach<-function(tab)
{
    # mtab<-ReadAndMerge(); tab<-MeanAndSigma(mtab)
    #     View(names(tab))
    return(
        as.data.frame(
            mt<-tbl_df(tab) %>%
                gather(Feature,mean,-Activity) %>%
                separate(Feature,c("id","num","Feature"),sep = "_") %>%
                select(-id,-num) %>%
                group_by(Activity,Feature) %>%
                summarize(Mean = mean(mean)) # %>%
#                 print
            )
        )
    # WriteStep5(mt,"step5.txt")
}


getReadAndMerged<-function(wd = "UCI_HAR_Dataset")
{
    # wd = "UCI_HAR_Dataset"
    fi<-file.info(wd)[1,"isdir"]
    if(fi != TRUE | is.na(fi)){
        message("I cannot find the working directory")
        return(-1)
    }
    oldwd<-getwd()
    setwd(wd)
    
    # Read Data and Var Names -------------------------------------------------
    # setwd("UCI_HAR_Dataset")
    # setwd("..")
    vNames<-getFeatures(".")
    aNames<-getActivities(".")
    
    XTrain<-read.table("train/X_train.txt",stringsAsFactors=F)
    XTest<-read.table("test/X_test.txt",stringsAsFactors=F)
    
    YTrain<-read.table("train/Y_train.txt",stringsAsFactors=F)
    YTest<-read.table("test/Y_test.txt",stringsAsFactors=F)
    
    subTrain<-read.table("train/subject_train.txt",stringsAsFactors=F)
    subTest<-read.table("test/subject_test.txt",stringsAsFactors=F)
    
    
    # Merges the training and the test sets to create one data set. -----------
    
    
    # Assign names to each variable from the features
    names(XTrain)<-vNames$V2
    names(XTest)<-vNames$V2
    
    # Now we add those activities based on the index given in the activity_labels
    XTrain$Activity<-sapply(YTrain$V1,function(x) as.factor(aNames[x,"V2"]))
    XTest$Activity<-sapply(YTest$V1,function(x) as.factor(aNames[x,"V2"]))
    
    # Summary data (for testing)
    # table(XTrain$Y); table(XTest$Y)
    
    # Merge the tables into tab
    tab<-XTrain; tab<-rbind(tab,XTest)
    
    # Clear out unused tables
    rm(aNames,subTest,subTrain,vNames,XTest,XTrain,YTest,YTrain)
    setwd(oldwd)
    
    return(tab)
}


WriteStep5<-function(tab,file="step5.txt")
{
    write.table(tab,file,row.names=F)
}


ReadStep5<-function(file="step5.txt")
{
    return(
        read.table(file,header=T,row.names=NULL)
    )
}


# Use descriptive activity names to name the activities -------------------


# Labels the data set with descriptive variable names.  -------------------


# tidy data set with the average of each variable -------------------------
# for each activity and each subject. -------------------------------------


