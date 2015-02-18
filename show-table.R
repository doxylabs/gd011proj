#!/opt/local/bin/Rscript 

# show-table.R

# See README.md for more information

source("utilities.R")

options(width=140, justify="left")
ReadStep5() %>% 
    print(justify="right")

