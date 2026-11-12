library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature_name"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

X_all <- rbind(x_train, x_test)
Y_all <- rbind(y_train, y_test)
Subject_all <- rbind(subject_train, subject_test)

colnames(X_all) <- features$feature_name

merged_data <- cbind(Subject_all, Y_all, X_all)

mean_std_cols <- grep("-(mean|std)\\(\\)", features$feature_name, value = TRUE)
tidy_data <- merged_data[, c("subject", "code", mean_std_cols)]

tidy_data$code <- activity_labels[tidy_data$code, 2]
colnames(tidy_data)[2] <- "activity"

names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)", "Mean", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)", "STD", names(tidy_data))
names(tidy_data) <- gsub("-", "", names(tidy_data))

final_tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

write.table(final_tidy_data, "tidy_data.txt", row.name = FALSE)