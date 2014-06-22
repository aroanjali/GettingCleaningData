data_sub_train <- read.table("./subject_train.txt")
data_sub_test <- read.table("./subject_test.txt")
data_sub_train_test <- rbind(data_sub_train,data_sub_test)

data_y_train <- read.table("./y_train.txt")
data_y_test <- read.table("./y_test.txt")
data_y_train_test <- rbind(data_y_train,data_y_test)

data_x_train <- read.table("./x_train.txt")
data_x_test <- read.table("./x_test.txt")
data_x_train_test <- rbind(data_x_train,data_x_test)
 


data_features <- read.table("./features.txt")
feat_vector <- data_features[2]

vector <- c()
vector <- feat_vector[,1]
names(data_x_train_test) <- vector

indices <- grepl('std\\(\\)|mean\\(\\)', names(data_x_train_test))
data_x_train_test_std_mean <- data_x_train_test[,indices]

data_x_train_test_sub_activity <- cbind(data_sub_train_test,data_y_train_test,data_x_train_test_std_mean)

colnames(data_x_train_test_sub_activity)[1] <- "SubjectID"
colnames(data_x_train_test_sub_activity)[2] <- "ActivityCode" 

data_activity <- read.table("./activity_labels.txt")
mergedData <- merge(data_activity,data_x_train_test_sub_activity,by.x="V1",by.y="ActivityCode")

colnames(mergedData)[1] <- "ActivityCode"
colnames(mergedData)[2] <- "ActivityDescription"

name_vect <- c()
name_vect <- names(data_x_train_test_std_mean)
tidy_data <- dcast(mergedData, SubjectID + ActivityCode + ActivityDescription ~ name_vect,mean)
write.table(tidy_data, "tidy_data.txt")
