
# Please make sure you have dplyr library installed
library(dplyr)

loadData <- function(file) {
        v <- scan(file, what = numeric())
        m <- matrix(v, ncol = 561, byrow = TRUE)
        m
}

setwd('C:\\Users\\Pablo\\Desktop\\Getting And Cleaning Data Project\\UCI HAR Dataset')

features <-read.table('.\\features.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
ytrain <-read.table('.\\train\\y_train.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
ytest <-read.table('.\\test\\y_test.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
activityLabels <-read.table('.\\activity_labels.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
strain <-read.table('.\\train\\subject_train.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
stest <-read.table('.\\test\\subject_test.txt',  header = FALSE, stringsAsFactors = FALSE, sep = ' ')
xtrain <- loadData('.\\train\\X_train.txt')
xtest <- loadData('.\\test\\X_test.txt')

# Join both datasets
joinedDS <- rbind(xtest, xtrain)

# Filter means and standard deviation columns
meansAndStds <- filter(features, grepl("mean\\(\\)|std\\(\\)", V2))
joinedDSMaS <- joinedDS[, meansAndStds$V1] 

# Add activity column
joinedDSMaS <- cbind(joinedDSMaS, rbind(ytest, ytrain))

# Add subject column
joinedDSMaS <- cbind(joinedDSMaS, rbind(stest, strain))

# Turn into data frame and re order columns
df <- data.frame(joinedDSMaS, stringsAsFactors = FALSE)


# Set activity lables  for the column
df <- df[, c(ncol(df)-1, ncol(df), 1:66)]

# Rename the columns properly
names(df) <- c('ActivityLabel', 'SubjectId', meansAndStds$V2)

# Clean the column names a little bit more and helps avoiding what seems to be a bug in summarise_each_
names(df) <-str_replace_all(names(df), "-|\\(|\\)", "")

# These add extra formatting but it may also lead to problems
#names(df) <-str_replace_all(names(df), "^[ft]", "")
#names(df) <- str_trim(str_replace_all(names(df), "[A-Z]", " \\0"), side = "left")

# Create a new data set with the average of each variable for each activity and each subject
by_activity_subject <- group_by(df, `ActivityLabel`, `SubjectId`)
df2 <- summarise_each_(by_activity_subject, funs(mean), names(by_activity_subject)[c(-1, -2)])
write.table (df2, 'Dataset2.txt', row.name = FALSE)

