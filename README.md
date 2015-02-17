# UCI_HAR_Dataset Assignment

See also: [CodeBook](https://github.com/jrherrick/gd011proj/blob/master/CodeBook.md) for more information on the data.

## Functions in utilities.R


### `ReadAndMerge(wd="UCI_HAR_Dataset")`

ReadAndMerge() receives a single argument `wd` as the working directory in which to find the *UCI HAR Dataset*. The default is `UCI_HAR_Dataset`, the directory left from unzipping the download. The function builds a merged table for the UCI_HAR_Dataset, assigning the variables names from the features.txt file and activities from the activity_labels.txt file. The activities are read from the YTest and YTrain.


### `MeanAndSigma(t)`

MeanAndSigma() receives a single table with factors in a variable named `Activity` and returns a a table of means and standard deviations for all variables, cut into factors as defined by the `Activity` column. *NOTE: a table built by ReadAndMerge() should work*.
