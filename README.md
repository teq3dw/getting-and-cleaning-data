Getting and Cleaning Data - Peer Assessment
========================================
This file describes how run_analysis.R script works.

* Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* rename the newly extracted folder to "data". Make sure the folder "data" and the run_analysis.R script are both in the current working directory.
* Use source("run_analysis.R"). You will find two output files generated in the current working directory:
  - merged_data.txt containing a data frame called cleandata.
  - data_with_means.txt containing a data frame called result.
* Use data <- read.table("data_with_means.txt") to read the file.
