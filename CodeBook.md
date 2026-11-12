# Code Book

This code book describes the source data, variables, units, and transformations applied in `run_analysis.R` to generate the final tidy dataset (`tidy_data.txt`).

## Study Design and Raw Data

The raw data originates from experiments carried out with a group of 30 volunteers aged 19–48 years. Each person performed six activities while wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.

* **Raw Training Set (`train/`):** 7,352 observations (70% of subjects).
* **Raw Test Set (`test/`):** 2,947 observations (30% of subjects).
* **Units:** All original feature measurements were normalized and bounded within the range **`[-1, 1]`**, making all measurement variables in the final dataset dimensionless (normalized units).

## Transformations Performed

The `run_analysis.R` script transforms the raw files into `tidy_data.txt` through the following steps:

1. **Merging:** Combined the training (`X_train`, `y_train`, `subject_train`) and test (`X_test`, `y_test`, `subject_test`) tables by rows (`rbind`), and joined subject IDs, activity codes, and feature vectors by columns (`cbind`).
2. **Feature Filtering:** Selected only the 66 features representing the mean (`-mean()`) and standard deviation (`-std()`) of each signal, discarding angle measurements and `meanFreq()` variables.
3. **Activity Labeling:** Mapped integer activity IDs (`1`–`6`) to factor/character labels defined in `activity_labels.txt`.
4. **Variable Renaming:** Applied systematic string replacements to produce clean, human-readable column names:
   * Leading `t` $\rightarrow$ `Time`
   * Leading `f` $\rightarrow$ `Frequency`
   * `Acc` $\rightarrow$ `Accelerometer`
   * `Gyro` $\rightarrow$ `Gyroscope`
   * `Mag` $\rightarrow$ `Magnitude`
   * `BodyBody` $\rightarrow$ `Body`
   * `-mean()` $\rightarrow$ `Mean`
   * `-std()` $\rightarrow$ `STD`
   * Removed all hyphens (`-`)
5. **Aggregation:** Grouped the dataset by `subject` (30 levels) and `activity` (6 levels) and calculated the arithmetic mean of each measurement variable for each group, yielding **180 rows** and **68 columns**.

## Variables in `tidy_data.txt`

### Identifiers

1. **`subject`** *(integer)*: Unique identifier of the volunteer who performed the experiment. Values range from `1` to `30`.
2. **`activity`** *(character)*: Descriptive name of the physical activity performed during measurement:
   * `WALKING` (code `1`)
   * `WALKING_UPSTAIRS` (code `2`)
   * `WALKING_DOWNSTAIRS` (code `3`)
   * `SITTING` (code `4`)
   * `STANDING` (code `5`)
   * `LAYING` (code `6`)

### Measurement Variables (Averaged per Subject and Activity)

All 66 numeric variables below represent the **mean of the normalized signal values** (dimensionless, bounded in `[-1, 1]`) for a given `subject` and `activity`. `X`, `Y`, and `Z` denote the 3-axial spatial directions.

#### Time-Domain Body & Gravity Acceleration Signals
* `TimeBodyAccelerometerMeanX`
* `TimeBodyAccelerometerMeanY`
* `TimeBodyAccelerometerMeanZ`
* `TimeBodyAccelerometerSTDX`
* `TimeBodyAccelerometerSTDY`
* `TimeBodyAccelerometerSTDZ`
* `TimeGravityAccelerometerMeanX`
* `TimeGravityAccelerometerMeanY`
* `TimeGravityAccelerometerMeanZ`
* `TimeGravityAccelerometerSTDX`
* `TimeGravityAccelerometerSTDY`
* `TimeGravityAccelerometerSTDZ`

#### Time-Domain Body Acceleration Jerk Signals
* `TimeBodyAccelerometerJerkMeanX`
* `TimeBodyAccelerometerJerkMeanY`
* `TimeBodyAccelerometerJerkMeanZ`
* `TimeBodyAccelerometerJerkSTDX`
* `TimeBodyAccelerometerJerkSTDY`
* `TimeBodyAccelerometerJerkSTDZ`

#### Time-Domain Body Gyroscope & Gyroscope Jerk Signals
* `TimeBodyGyroscopeMeanX`
* `TimeBodyGyroscopeMeanY`
* `TimeBodyGyroscopeMeanZ`
* `TimeBodyGyroscopeSTDX`
* `TimeBodyGyroscopeSTDY`
* `TimeBodyGyroscopeSTDZ`
* `TimeBodyGyroscopeJerkMeanX`
* `TimeBodyGyroscopeJerkMeanY`
* `TimeBodyGyroscopeJerkMeanZ`
* `TimeBodyGyroscopeJerkSTDX`
* `TimeBodyGyroscopeJerkSTDY`
* `TimeBodyGyroscopeJerkSTDZ`

#### Time-Domain Signal Magnitudes (Euclidean Norm)
* `TimeBodyAccelerometerMagnitudeMean`
* `TimeBodyAccelerometerMagnitudeSTD`
* `TimeGravityAccelerometerMagnitudeMean`
* `TimeGravityAccelerometerMagnitudeSTD`
* `TimeBodyAccelerometerJerkMagnitudeMean`
* `TimeBodyAccelerometerJerkMagnitudeSTD`
* `TimeBodyGyroscopeMagnitudeMean`
* `TimeBodyGyroscopeMagnitudeSTD`
* `TimeBodyGyroscopeJerkMagnitudeMean`
* `TimeBodyGyroscopeJerkMagnitudeSTD`

#### Frequency-Domain Signals (Fast Fourier Transform)
* `FrequencyBodyAccelerometerMeanX`
* `FrequencyBodyAccelerometerMeanY`
* `FrequencyBodyAccelerometerMeanZ`
* `FrequencyBodyAccelerometerSTDX`
* `FrequencyBodyAccelerometerSTDY`
* `FrequencyBodyAccelerometerSTDZ`
* `FrequencyBodyAccelerometerJerkMeanX`
* `FrequencyBodyAccelerometerJerkMeanY`
* `FrequencyBodyAccelerometerJerkMeanZ`
* `FrequencyBodyAccelerometerJerkSTDX`
* `FrequencyBodyAccelerometerJerkSTDY`
* `FrequencyBodyAccelerometerJerkSTDZ`
* `FrequencyBodyGyroscopeMeanX`
* `FrequencyBodyGyroscopeMeanY`
* `FrequencyBodyGyroscopeMeanZ`
* `FrequencyBodyGyroscopeSTDX`
* `FrequencyBodyGyroscopeSTDY`
* `FrequencyBodyGyroscopeSTDZ`
* `FrequencyBodyAccelerometerMagnitudeMean`
* `FrequencyBodyAccelerometerMagnitudeSTD`
* `FrequencyBodyAccelerometerJerkMagnitudeMean`
* `FrequencyBodyAccelerometerJerkMagnitudeSTD`
* `FrequencyBodyGyroscopeMagnitudeMean`
* `FrequencyBodyGyroscopeMagnitudeSTD`
* `FrequencyBodyGyroscopeJerkMagnitudeMean`
* `FrequencyBodyGyroscopeJerkMagnitudeSTD`
