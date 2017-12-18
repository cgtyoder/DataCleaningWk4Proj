# R script to convert raw to tidy data in Data Cleaning class, Week 4 Project

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
    newaccel <- cbind(
        xtabs(TimeBodyAccelMeanX ~ SubjectID + Activity, data = aggregate(TimeBodyAccelMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelMeanY ~ SubjectID + Activity, data = aggregate(TimeBodyAccelMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelMeanZ ~ SubjectID + Activity, data = aggregate(TimeBodyAccelMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelSDX ~ SubjectID + Activity, data = aggregate(TimeBodyAccelSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelSDY ~ SubjectID + Activity, data = aggregate(TimeBodyAccelSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelSDZ ~ SubjectID + Activity, data = aggregate(TimeBodyAccelSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelMeanX ~ SubjectID + Activity, data = aggregate(TimeGravityAccelMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelMeanY ~ SubjectID + Activity, data = aggregate(TimeGravityAccelMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelMeanZ ~ SubjectID + Activity, data = aggregate(TimeGravityAccelMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelSDX ~ SubjectID + Activity, data = aggregate(TimeGravityAccelSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelSDY ~ SubjectID + Activity, data = aggregate(TimeGravityAccelSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeGravityAccelSDZ ~ SubjectID + Activity, data = aggregate(TimeGravityAccelSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMeanX ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMeanY ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMeanZ ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkSDX ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkSDY ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkSDZ ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroMeanX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroMeanY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroMeanZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroSDX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroSDY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroSDZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMeanZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDX ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDY ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkSDZ ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelMagMean ~ SubjectID + Activity, data = aggregate(TimeBodyAccelMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelMagSD ~ SubjectID + Activity, data = aggregate(TimeBodyAccelMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMagMean ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMagSD ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMagMean ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyAccelJerkMagSD ~ SubjectID + Activity, data = aggregate(TimeBodyAccelJerkMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroMagMean ~ SubjectID + Activity, data = aggregate(TimeBodyGyroMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroMagSD ~ SubjectID + Activity, data = aggregate(TimeBodyGyroMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMagMean ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(TimeBodyGyroJerkMagSD ~ SubjectID + Activity, data = aggregate(TimeBodyGyroJerkMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelMeanX ~ SubjectID + Activity, data = aggregate(FFTBodyAccelMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelMeanY ~ SubjectID + Activity, data = aggregate(FFTBodyAccelMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelMeanZ ~ SubjectID + Activity, data = aggregate(FFTBodyAccelMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelSDX ~ SubjectID + Activity, data = aggregate(FFTBodyAccelSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelSDY ~ SubjectID + Activity, data = aggregate(FFTBodyAccelSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelSDZ ~ SubjectID + Activity, data = aggregate(FFTBodyAccelSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkMeanX ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkMeanY ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkMeanZ ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkSDX ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkSDY ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkSDZ ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroMeanX ~ SubjectID + Activity, data = aggregate(FFTBodyGyroMeanX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroMeanY ~ SubjectID + Activity, data = aggregate(FFTBodyGyroMeanY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroMeanZ ~ SubjectID + Activity, data = aggregate(FFTBodyGyroMeanZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroSDX ~ SubjectID + Activity, data = aggregate(FFTBodyGyroSDX ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroSDY ~ SubjectID + Activity, data = aggregate(FFTBodyGyroSDY ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroSDZ ~ SubjectID + Activity, data = aggregate(FFTBodyGyroSDZ ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelMagMean ~ SubjectID + Activity, data = aggregate(FFTBodyAccelMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelMagSD ~ SubjectID + Activity, data = aggregate(FFTBodyAccelMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkMagMean ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyAccelJerkMagSD ~ SubjectID + Activity, data = aggregate(FFTBodyAccelJerkMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroMagMean ~ SubjectID + Activity, data = aggregate(FFTBodyGyroMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroMagSD ~ SubjectID + Activity, data = aggregate(FFTBodyGyroMagSD ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroJerkMagMean ~ SubjectID + Activity, data = aggregate(FFTBodyGyroJerkMagMean ~ SubjectID + Activity, tidyset, mean)),
        xtabs(FFTBodyGyroJerkMagSD ~ SubjectID + Activity, data = aggregate(FFTBodyGyroJerkMagSD ~ SubjectID + Activity, tidyset, mean))
    )
    
    # save new data frame to txt file
    write.table(newaccel, file = "tidyaverages.txt", row.names = FALSE)
}
