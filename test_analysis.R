source("./run_analysis.R")
data <- read.table("./tidydataset.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
View(data)