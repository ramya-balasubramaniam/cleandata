run_analysis <- function(x){                                      # x has the name of the directory that has the data downloaded
	library("plyr")                                                 # from the internet
	filename <- paste("./",x,"/features.txt",sep ="")
	filename1_test <- paste("./",x,"/test/subject_test.txt",sep ="")       # initializing the path of localized files
	filename2_test <- paste("./",x,"/test/X_test.txt",sep ="")
	filename3_test <- paste("./",x,"/test/y_test.txt",sep ="")
	filename1_trn <- paste("./",x,"/train/subject_train.txt",sep ="")
	filename2_trn <- paste("./",x,"/train/X_train.txt",sep ="")
	filename3_trn <- paste("./",x,"/train/y_train.txt",sep ="")
	print("Initialized the filenames")
	a <- readLines(filename1_test)                               # files are read from the specified path and stored in R objects
	b <- readLines(filename3_test)
	c <- read.table(filename2_test)
	dft1 <- data.frame(a)
	dft2 <- data.frame(b)
	d1 <- cbind(dft1,dft2,c)                                    # final R object with test data
	print("Finished compiling the test data")                   
	rm(a,b,c,dft1,dft2)
	a <- readLines(filename1_trn)
	b <- readLines(filename3_trn)
	c <- read.table(filename2_trn)
	dft1 <- data.frame(a)
	dft2 <- data.frame(b)
	d2 <- cbind(dft1,dft2,c)                                   # final R object with train data
	print("Finished compiling the train data")
	rm(a,b,c,dft1,dft2)
	d3 <- rbind(d1,d2)                                         
	print("Merged the train & test data")
	feature_561 <- read.table(filename)
	feature_561 <- feature_561[,2]
	feature_561 <- as.character(feature_561)
	replace <- c("Subject_ID","Activity_ID",feature_561)
	names(replace) <- names(d3)
	d4 <- rename(d3,replace)
	print("Replaced the names of columns in composite data")
	write.csv(d4,file = "merged_data.csv",row.names=FALSE)     # final merged data is stored in a .csv file
	print("Created the merged data in .csv file")
	rm(d1,d2,d3,d4,filename,filename1_test,filename2_test,filename3_test,filename1_trn,filename2_trn,filename3_trn)
	merged_data <- read.csv("./merged_data.csv")
	b <- names(merged_data)
	select1 <- grep("mean",b,ignore.case = TRUE) 
	select2 <- grep("std",b,ignore.case = TRUE)
	selected_col <- c(b[1],b[2],b[select1],b[select2])
	extract_data <- merged_data[,selected_col]                 # Dataset with only the columns or variables measuring mean & STD
	print("Data with measurements of mean and STD extracted")
	rm(merged_data,b,select1,select2,selected_col)
	filename <- paste("./",x,"/activity_labels.txt",sep ="")
	Activity_list <- read.table(filename)
	Activity_list <- Activity_list[,2]                       # final sorted dataset with Activity labels and variable names 
	Activity_list <- as.character(Activity_list)             # replaced from activity_labels.txt and features.txt
	extract_data[,"Activity_ID"] <- Activity_list[extract_data[,"Activity_ID"]]
	print("Assigned the appropriate activity name")
	extract_data <- extract_data[order(extract_data$Subject_ID,extract_data$Activity_ID),]
	print("Extracted data was sorted")
	value_4_avg <- names(extract_data)
	value_4_avg <- value_4_avg[3:length(value_4_avg)]
	i <- 1
	j <- 1
	k <- 1
	subject_ID <- vector(mode = "numeric")
	activity_label <- vector(mode = "character")
	m <- matrix(nrow =180, ncol=length(value_4_avg))        # calculation of average of all variables for a particular Subject &
	while(j<=30 & k<=6){                                    # activity label for.eg. subject ID = 1 & activity label = LAYING
		x <- extract_data[extract_data$Subject_ID == j & extract_data$Activity_ID == Activity_list[k],value_4_avg]
		if(nrow(x)==0){
			if(j<=30 & k<6){
				k <- k+1                                       
				next
			} 
			else if(j<30 & k==6){
				k <- 1
				j <- j+1
				next
			}
			else if(j==30 & k==6){
				break
			}
		}
			subject_ID[i] <- j
			activity_label[i] <- Activity_list[k]
			g <- mapply(mean,x)
			g <- as.vector(g)
			m[i,]<-g
			i <- i+1
			if(j<30 & k<6){
				k <- k+1
				next
			}
			else if(j<30 & k==6){
				j <- j+1
				k <- 1
				next
			}
			else if(j==30 & k<6){
				k <- k+1
				next
			}
			else if(j==30 & k==6){
				break
			}
	}
	colnames(m)<- value_4_avg
	subject_ID <- data.frame(subject_ID) 
	activity_label <- data.frame(activity_label)
	d1 <- cbind(subject_ID,activity_label,m)         
	write.table(d1,file="final_cleandata.txt",row.names=FALSE,eol = "\r\n")    # finally generated tidy data is saved in working
	rm(m,activity_label,Activity_list,subject_ID,extract_data,x,i,j,k,d1)      # directory as final_cleandata.txt
	print("The final file has been written")
}
