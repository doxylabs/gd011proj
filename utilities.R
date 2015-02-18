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
    tab$Feature <- sapply(tab$Feature, function(x) gsub("tGravity","Gravity",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("tBody","Body",x) )
    
    tab$Feature <- sapply(tab$Feature, function(x) gsub("GyroJerkMag","AngularVelocityJerk",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("AccJerkMag","LinearAccelerationJerk",x) )
    
    tab$Feature <- sapply(tab$Feature, function(x) gsub("AccMag","LinearAcceleration",x) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("GyroMag","AngularVelocity",x) )

    tab$Feature <- sapply(tab$Feature, function(x) gsub("-mean()","Mean",x,fixed=T) )
    tab$Feature <- sapply(tab$Feature, function(x) gsub("-std()","Sigma",x,fixed=T) )

    return(tab)

}

getMeanAndSigma<-function(tab)
{
    # Extracts mean and standard deviation for each measure -------------------
    t<-tbl_df(tab)
    
    return(
        as.data.frame(
            t %>% 
                select(Subject,Activity,
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
    return(
        as.data.frame(
            tbl_df(tab) %>%
                gather(Feature,mean,-Activity,-Subject) %>%
                separate(Feature,c("id","num","Feature"),sep = "_") %>%
                select(-id,-num) %>%
                group_by(Subject,Activity,Feature) %>%
                summarize(Mean = mean(mean))
            )
        )
}


getReadAndMerged<-function(wd = "UCI_HAR_Dataset")
{
    fi<-file.info(wd)[1,"isdir"]
    if(fi != TRUE | is.na(fi)){
        message("I cannot find the working directory")
        return(-1)
    }
    oldwd<-getwd()
    setwd(wd)
    
    # Read Data and Var Names -------------------------------------------------
    vNames<-getFeatures(".")
    aNames<-getActivities(".")
    
    XTrain<-read.table("train/X_train.txt",stringsAsFactors=F)
    XTest<-read.table("test/X_test.txt",stringsAsFactors=F)
    
    YTrain<-read.table("train/y_train.txt",stringsAsFactors=F)
    YTest<-read.table("test/y_test.txt",stringsAsFactors=F)
    
    subTrain<-read.table("train/subject_train.txt",stringsAsFactors=F)
    subTest<-read.table("test/subject_test.txt",stringsAsFactors=F)
    
    
    # Merges the training and the test sets to create one data set. -----------    
    
    # Assign names to each variable from the features
    names(XTrain)<-vNames$V2
    names(XTest)<-vNames$V2
    
    # Add activities based on the index (y_train/y_test) translated by the activity_labels
    XTrain$Activity<-sapply(YTrain$V1,function(x) as.factor(aNames[x,"V2"]))
    XTest$Activity<-sapply(YTest$V1,function(x) as.factor(aNames[x,"V2"]))
    
    # Similarly, add the Subject numbers. This does not have a translation index, just a number factor.
    XTrain$Subject<-subTrain[,"V1"]
    XTest$Subject<-subTest[,"V1"]
    
    # Merge the tables into tab
    tab<-XTrain; tab<-rbind(tab,XTest)
    
    # Change the Subject to a factor (after merge, as there's no guarantee we're sampling the same folks)
#     tab$Subject<-as.factor(tab$Subject)
    
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

