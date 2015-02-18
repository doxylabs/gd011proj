# UCI_HAR_Dataset Assignment

See also: [CodeBook](https://github.com/jrherrick/gd011proj/blob/master/CodeBook.md) for more information on the data. Take a look at [Assignment.md](https://github.com/jrherrick/gd011proj/blob/master/Assignment.md) for information on the assignment proper.


## Theory of Operation

![w01.jpg](w01.png)

## Scripts and Utilities

### data-reset.R

Assuming nothing about how you have set up your data environment, you will find data-reset.R useful in setting up the dataset. Run it from your development environment, or on the CLI with Rscript like so, adding a full path to Rscript and data-reset.R if needed:

    Rscript data-reset.R

This script depends on curl being available on your system. The script could probably be smarter about this -- this is left as an exercise for the reader.

### run-analysis.R

    Rscript run-analysis.R

### show-table.R

    show-table.R

### utilities.R

This file is not intended to be run, instead providing the functions needed by the scripts.

#### getActivities(wd = "UCI_HAR_Dataset")

The Dataset contains a file called `activity_labels.txt`. This file contains the factors against which we bucket our data. Each activity was recorded and stored with each data point, indexed against this file.

    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

#### getAveragedEach(tab)

#### getFeatures(wd = "UCI_HAR_Dataset")

#### getMeanAndSigma(tab)

Receives a single table with factors in a variable named `Activity` and returns a table of means and standard deviations for all variables, cut into factors as defined by the `Activity` column.

*NOTE: a table built by getReadAndMerged() should work as input*.

#### getReadAndMerged(wd = "UCI_HAR_Dataset")

getReadAndMerged() receives a single argument `wd` as the working directory in which to find the *UCI HAR Dataset*. The default is `UCI_HAR_Dataset`, the directory created by the data-reset.R script. The function builds a merged table for the UCI_HAR_Dataset, assigning the variables names from the features.txt file and activities from the activity_labels.txt file. The activities are read from the YTest and YTrain.

#### setTidyNames(tab)



#### ReadStep5(file="step5.txt")

#### WriteStep5(tab,file="step5.txt")

