# UCI HAR Dataset Assignment

See also: [CodeBook](https://github.com/jrherrick/gd011proj/blob/master/CodeBook.md) for more information on the data processing and output.

Take a look at [Assignment.md](https://github.com/jrherrick/gd011proj/blob/master/Assignment.md) for information on the assignment details.


## Theory of Operation

To get from an empty working directory to an output file, first clone the git repository with 

    git clone https://github.com/jrherrick/gd011proj.git
    
...then cd into the gd011proj directory that was created. At this point, you'll want to run `data-reset.R`. This will download the data we'll work with and set it up in the directory expected. `run-analysis.R` will then read the data and generate `step5.txt`.

![w01.jpg](w01.png)

Once `step5.txt` is in place, `show-table.R` will output the data to the screen in a readable fixed-width format. You may redirect this output to a file if needed, but **do not** use this as input to to `show-table.R`.

![w02.jpg](w02.png)

## Scripts and Utilities

These three utilities and utility library are used to execute the instructions in the assignment. While technically, run-analysis.R will do everything required by the assignment, it leaves a lot of assumptions open. No previous knowledge of the data are assumed here.

### data-reset.R

Assuming nothing about how you have set up your data environment, you will find data-reset.R useful in setting up the dataset as expected by run-analysis.R. Run data-reset.R from your development environment, or on the CLI with Rscript like so, adding a full path to Rscript and data-reset.R if needed:

    Rscript data-reset.R

This script depends on curl being available on your system. The script could probably be smarter about this -- this is left as an exercise for the reader.

### run-analysis.R

Run the script in your IDE, with `./run-analysis.R`, or with an explicit Rscript execution like so:

    Rscript run-analysis.R

You will notice that run-analysis.R is quite sparse, leaving all the work to utility functions in utilities.R. These utilities are broken out into (essentially) the high-level steps from the assignment. 

### show-table.R

Yields a simple, visually aligned, fixed-width summary of the table output by run-analysis.R.

    show-table.R

### utilities.R

*NOTE: This file is not intended to be run, instead providing the functions needed by the scripts.*

Details on how the utilities transform data are in the codebook in the transformation section.
