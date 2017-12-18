# DataCleaningWk4Proj

## Code Book

This data is taken from the Coursera Data Cleaning Class, Week 4 Project download assignment.

### Data Variables

These data variables summarize the data.frame 'tidyset' created in the run_analysis.R file.

SubjectID:
the ID number of the subject in the test.  Numbers go from 1-30.

Activity:
The name of the activity being tested. It is one of: "Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying"

The remaining 66 variable names are pieced together based on several variables.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAccel-XYZ and TimeGyro-XYZ. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAccel-XYZ and TimeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccelJerk-XYZ and TimeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FFTBodyAcc-XYZ, FFTBodyAccJerk-XYZ, FFTBodyGyro-XYZ, FFTBodyAccJerkMag, FFTBodyGyroMag, FFTBodyGyroJerkMag. (Note the 'FFT' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Following are these 66 variable names, with their position in the data frame:
 3 "TimeBodyAccelMeanX", 
 4 "TimeBodyAccelMeanY", 
 5 "TimeBodyAccelMeanZ",
 6 "TimeBodyAccelSDX", 
 7 "TimeBodyAccelSDY", 
 8 "TimeBodyAccelSDZ", 
 9 "TimeGravityAccelMeanX", 
10 "TimeGravityAccelMeanY", 
11 "TimeGravityAccelMeanZ", 
12 "TimeGravityAccelSDX", 
13 "TimeGravityAccelSDY", 
14 "TimeGravityAccelSDZ", 
15 "TimeBodyAccelJerkMeanX", 
16 "TimeBodyAccelJerkMeanY", 
17 "TimeBodyAccelJerkMeanZ", 
18 "TimeBodyAccelJerkSDX", 
19 "TimeBodyAccelJerkSDY", 
20 "TimeBodyAccelJerkSDZ", 
21 "TimeBodyGyroMeanX", 
22 "TimeBodyGyroMeanY", 
23 "TimeBodyGyroMeanZ", 
24 "TimeBodyGyroSDX", 
25 "TimeBodyGyroSDY", 
26 "TimeBodyGyroSDZ", 
27 "TimeBodyGyroJerkMeanX", 
28 "TimeBodyGyroJerkMeanY", 
29 "TimeBodyGyroJerkMeanZ", 
30 "TimeBodyGyroJerkSDX", 
31 "TimeBodyGyroJerkSDY", 
32 "TimeBodyGyroJerkSDZ", 
33 "TimeBodyAccelMagMean", 
34 "TimeBodyAccelMagSD", 
35 "TimeGravityAccelMagMean", 
36 "TimeGravityAccelMagSD", 
37 "TimeBodyAccelJerkMagMean", 
38 "TimeBodyAccelJerkMagSD", 
39 "TimeBodyGyroMagMean", 
40 "TimeBodyGyroMagSD", 
41 "TimeBodyGyroJerkMagMean", 
42 "TimeBodyGyroJerkMagSD", 
43 "FFTBodyAccelMeanX", 
44 "FFTBodyAccelMeanY", 
45 "FFTBodyAccelMeanZ", 
46 "FFTBodyAccelSDX", 
47 "FFTBodyAccelSDY", 
48 "FFTBodyAccelSDZ", 
49 "FFTBodyAccelJerkMeanX", 
50 "FFTBodyAccelJerkMeanY", 
51 "FFTBodyAccelJerkMeanZ", 
52 "FFTBodyAccelJerkSDX", 
53 "FFTBodyAccelJerkSDY", 
54 "FFTBodyAccelJerkSDZ", 
55 "FFTBodyGyroMeanX", 
56 "FFTBodyGyroMeanY", 
57 "FFTBodyGyroMeanZ", 
58 "FFTBodyGyroSDX", 
59 "FFTBodyGyroSDY", 
60 "FFTBodyGyroSDZ", 
61 "FFTBodyAccelMagMean", 
62 "FFTBodyAccelMagSD", 
63 "FFTBodyAccelJerkMagMean", 
64 "FFTBodyAccelJerkMagSD", 
65 "FFTBodyGyroMagMean", 
66 "FFTBodyGyroMagSD", 
67 "FFTBodyGyroJerkMagMean", 
68 "FFTBodyGyroJerkMagSD" 
