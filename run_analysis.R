# R script to convert raw to tidy data in Data Cleaning class, Week 4 Project
library(reshape2)


run_analysis <- function()
{
    subjectFiles = c("UCI HAR Dataset/test/subject_test.txt", 
                     "UCI HAR Dataset/train/subject_train.txt")
    y_files = c("UCI HAR Dataset/test/y_test.txt", "UCI HAR Dataset/train/y_train.txt")
    X_files = c("UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/train/X_train.txt")
    
    # confirm all files are present
    if (sum(file.exists(c(subjectFiles, y_files, X_files))) != 6)
    {
        stop("Some data files are missing - stopping.")
    }
    
    # 561 cols of the X_[test|train].txt files - only get mean/SD data
    X_fileCols = c(rep("numeric", 6), rep("NULL", 34), 
                   rep("numeric", 6), rep("NULL", 34), 
                   rep("numeric", 6), rep("NULL", 34), 
                   rep("numeric", 6), rep("NULL", 34), 
                   rep("numeric", 6), rep("NULL", 34), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 6), rep("NULL", 73), 
                   rep("numeric", 6), rep("NULL", 73), 
                   rep("numeric", 6), rep("NULL", 73), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 11), 
                   rep("numeric", 2), rep("NULL", 18))
    
    # add X_[test|train].txt to the data frame, but only columns related to
    # mean & SD
    Xintermed <- do.call(rbind, lapply(X_files, read.table, colClasses = X_fileCols))

    # load in subject_* & y_* files
    ySubjIntermed <- cbind(do.call(rbind, lapply(subjectFiles, read.table)),
                           do.call(rbind, lapply(y_files, read.table)))
    
    tidyset <- cbind(ySubjIntermed, Xintermed)
    
    # add nice column names to the data frame
    colnames(tidyset) <- 
        c("SubjectID", "Activity", 
          "TimeBodyAccelMeanX", "TimeBodyAccelMeanY", "TimeBodyAccelMeanZ", 
          "TimeBodyAccelSDX", "TimeBodyAccelSDY", "TimeBodyAccelSDZ", 
          "TimeGravityAccelMeanX", "TimeGravityAccelMeanY", "TimeGravityAccelMeanZ", 
          "TimeGravityAccelSDX", "TimeGravityAccelSDY", "TimeGravityAccelSDZ", 
          "TimeBodyAccelJerkMeanX", "TimeBodyAccelJerkMeanY", "TimeBodyAccelJerkMeanZ", 
          "TimeBodyAccelJerkSDX", "TimeBodyAccelJerkSDY", "TimeBodyAccelJerkSDZ", 
          "TimeBodyGyroMeanX", "TimeBodyGyroMeanY", "TimeBodyGyroMeanZ", 
          "TimeBodyGyroSDX", "TimeBodyGyroSDY", "TimeBodyGyroSDZ", 
          "TimeBodyGyroJerkMeanX", "TimeBodyGyroJerkMeanY", "TimeBodyGyroJerkMeanZ", 
          "TimeBodyGyroJerkSDX", "TimeBodyGyroJerkSDY", "TimeBodyGyroJerkSDZ", 
          "TimeBodyAccelMagMean", "TimeBodyAccelMagSD", 
          "TimeGravityAccelMagMean", "TimeGravityAccelMagSD", 
          "TimeBodyAccelJerkMagMean", "TimeBodyAccelJerkMagSD", 
          "TimeBodyGyroMagMean", "TimeBodyGyroMagSD", 
          "TimeBodyGyroJerkMagMean", "TimeBodyGyroJerkMagSD", 
          "FFTBodyAccelMeanX", "FFTBodyAccelMeanY", "FFTBodyAccelMeanZ", 
          "FFTBodyAccelSDX", "FFTBodyAccelSDY", "FFTBodyAccelSDZ", 
          "FFTBodyAccelJerkMeanX", "FFTBodyAccelJerkMeanY", "FFTBodyAccelJerkMeanZ", 
          "FFTBodyAccelJerkSDX", "FFTBodyAccelJerkSDY", "FFTBodyAccelJerkSDZ", 
          "FFTBodyGyroMeanX", "FFTBodyGyroMeanY", "FFTBodyGyroMeanZ", 
          "FFTBodyGyroSDX", "FFTBodyGyroSDY", "FFTBodyGyroSDZ", 
          "FFTBodyAccelMagMean", "FFTBodyAccelMagSD", 
          "FFTBodyAccelJerkMagMean", "FFTBodyAccelJerkMagSD", 
          "FFTBodyGyroMagMean", "FFTBodyGyroMagSD", 
          "FFTBodyGyroJerkMagMean", "FFTBodyGyroJerkMagSD"
        )
    
    # give descriptive activity names
    tidyset$Activity[tidyset$Activity == 1] <- "Walking"
    tidyset$Activity[tidyset$Activity == 2] <- "WalkingUpstairs"
    tidyset$Activity[tidyset$Activity == 3] <- "WalkingDownstairs"
    tidyset$Activity[tidyset$Activity == 4] <- "Sitting"
    tidyset$Activity[tidyset$Activity == 5] <- "Standing"
    tidyset$Activity[tidyset$Activity == 6] <- "Laying"

    
    # create new data frame with the ave of each var for each activity 
    # and each subject
    meltTidy <- melt(tidyset, id = c("SubjectID", "Activity"))
    newaccel <- dcast(meltTidy, SubjectID + Activity ~ variable, mean)
    
    # save new data frame to txt file
    write.table(newaccel, file = "tidyaverages.txt", row.names = FALSE)
}
