# Getting and Cleaning Data - Course Project

This repository contains the R script and documentation for the **Getting and Cleaning Data** course project on Coursera. The goal of the project is to collect, clean, and transform raw wearable computing data into a tidy dataset ready for downstream analysis.

## Dataset

The data used in this project comes from the **Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset)**, collected from the accelerometers and gyroscopes of a Samsung Galaxy S II smartphone worn by 30 subjects performing six daily activities.

* **Source:** [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* **Data Archive:** [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Repository Files

* **`run_analysis.R`**: The R script that loads, merges, cleans, labels, and summarizes the raw dataset to produce `tidy_data.txt`.
* **`CodeBook.md`**: A codebook describing the variables, units, experimental design, and all transformations performed on the data.
* **`README.md`**: This file, explaining how the repository is structured and how to execute the analysis.

## How to Run the Analysis

1. Download and unzip the dataset so that the **`UCI HAR Dataset`** folder is located in your R working directory.
2. Ensure the `dplyr` package is installed in R:
   ```r
   install.packages("dplyr")
   ```
3. Run the script in R or RStudio:
   ```r
   source("run_analysis.R")
   ```

## How `run_analysis.R` Works

The script executes the five required data-cleaning steps sequentially:

1. **Merges the training and test sets:** Reads `X_train.txt`, `y_train.txt`, `subject_train.txt`, `X_test.txt`, `y_test.txt`, and `subject_test.txt`, combining them into a single dataset of 10,299 observations and 563 columns.
2. **Extracts mean and standard deviation measurements:** Filters the 561 feature columns using regular expressions (`-(mean|std)\\(\\)`) to retain only the 66 measurements corresponding to mean and standard deviation values, alongside `subject` and `activity`.
3. **Applies descriptive activity names:** Replaces numeric activity codes (`1` through `6`) with their corresponding labels from `activity_labels.txt` (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`).
4. **Labels variables descriptively:** Expands abbreviations into readable names (e.g., prefix `t` to `Time`, prefix `f` to `Frequency`, `Acc` to `Accelerometer`, `Gyro` to `Gyroscope`, `Mag` to `Magnitude`, removes parentheses/hyphens, and fixes duplicate `BodyBody` strings).
5. **Creates an independent tidy dataset (`tidy_data.txt`):** Groups the cleaned dataset by `subject` and `activity`, computes the average of each of the 66 variables for every subject-activity pair (180 rows × 68 columns), and exports the result using `write.table(..., row.name = FALSE)`.

## Reading the Output Dataset

To inspect the generated `tidy_data.txt` file in R, use:

```r
data <- read.table("tidy_data.txt", header = TRUE)
View(data)
```
