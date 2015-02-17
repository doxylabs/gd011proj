#!/opt/local/bin/Rscript

# pull-data.R
# See README.md for details.



rFile<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
lFile<-"UCI_HAR_Dataset.zip"
lDir<-"UCI_HAR_Dataset"

if(is.na(file.info(lFile)[1,"size"])){
    message("zipfile not found. Attempting to download with curl.")
    download.file(rFile,lFile,method="curl")
}else{
    message("zipfile found. Remove it to re-download.")
}

# Extract data
if(!is.na(file.info(lDir)[1,"isdir"])){
    message("Found directory -- Removing.")
    unlink(lDir,recursive=T)
}

unzip(lFile)
file.rename("UCI\ HAR\ Dataset",lDir)
