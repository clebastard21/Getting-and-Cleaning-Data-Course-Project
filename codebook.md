# Codebook
## Variables
- features: Contains data from features.txt file from the downloaded file
- activities: Contains data from activity_labels.txt file from the downloaded file
- subject_test: Contains data from subject_test.txt file from the downloaded file
- x_test: Contains data from x_test.txt file from the downloaded file
- y_test: Contains data from y_test.txt file from the downloaded file
- subject_train: Contains data from subject_train.txt file from the downloaded file
- x_train: Contains data from x_train.txt file from the downloaded file
- y_train: Contains data from y_train.txt file from the downloaded file
## Data
- mergeSubject: merge subject data
- mergeX: Merge X data
- mergeY: Merge Y data
- mergeData: Combine all the data together
- tidyData: Dataset with only the measurements on the mean and standard deviation
## Transformations
| Original Label | Transformed Label |
|--|--|
| code | activity |
| Starts with "t" | time |
| Starts with "f" | frequency |
| Contains "Acc" | Accelerometer |
| Contains "Gyro" | Gyroscope |
| Contains "Mag" | Magnitude |
| Contains "BodyBody" | Body |
