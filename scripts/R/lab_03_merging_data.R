library(tidyverse) # data formatting and graphing tools


# 1.0. Importing, merging, and relabeling, the data. 
setwd("~Desktop/TEXTBOOKS & RESOURCES - PhD/FALL 2025/INSTRUMENTATION/PhysTher5110")

list.files()

list.files("./data")
list.files("./data/EEG_sub_files/")

setwd("~/GitHub/ReproRehab/data/EEG_sub_files/")

setwd("~/Desktop/TEXTBOOKS & RESOURCES - PhD/FALL 2025/INSTRUMENTATION/PhysTher5110/data/EEG_sub_files")

# Testing out importing data with 1 subject:
test <- read.csv("./oa01_ec.csv",
                    header=TRUE, 
                    stringsAsFactors = TRUE)

head(test)

file_names <- list.files()
file_names
file_names[1]
file_names[7]

# A basic for-loop:
for(i in seq(1:10)) {
  print(i)
}

for(name in file_names) {
  print(name)
}


k = 0
for(file in file_names) {
    k = k+1
    print(file)
    print(k)
}



# Reading in the individual subjects and merging into a master file
if(1>=2){
  "Oh yeah!"
}
# Evaluates to true, returns Oh yeah!

file_names[1]
if(file_names[1]=="oa01_ec.csv"){
  "TRUE"
}
# Evaluates to true, returns Oh yeah!

if(file_names[1]=="OA01_ec.csv"){
  "Oh yeah!"
}
# Evaluates to false, returns nothing


if(file_names[1]=="OA01_ec.csv"){
  "Oh yeah!"
} else {"Oh No!"}
# Evaluates to false, returns Oh No!


# Putting an if else statement inside of our for-lopp
for(name in file_names) {
  print(name) #PRINT NAME
  subject <- read.csv(name, #READING IMPORTED CSV FILE
                      header=TRUE, 
                      stringsAsFactors = TRUE) 
  
  if (!exists("MASTER")){
    MASTER <- data.frame(subject)
    MASTER$file_id <- name
    
    
  } else {
    temp_dataset <- data.frame(subject)
    temp_dataset$file_id <-  name
    
    MASTER<-rbind(MASTER, temp_dataset)
    
    rm(temp_dataset)
  }
}


head(MASTER)

# move the file ID and Hz columns to the front of the dataset
MASTER <- MASTER %>% relocate(file_id)
MASTER <- MASTER %>% select(-X)

head(MASTER)

#Class of variable
class(MASTER$file_id)

# Break the file id into subject name and the condition
str_split(MASTER$file_id, "_")[[1]]


MASTER$subID <- factor(map_chr(str_split(MASTER$file_id, "_"), 1))

str_split(MASTER$file_id, "_")[[1]]

MASTER$condition <- factor(map_chr(str_split(MASTER$file_id, "_"), 1))
str_split(MASTER$condition, "_")[[1]][1])

str_extract(str_split(file_names, "_")[[1]][2], "[A-Za-z]+")

MASTER$file_id <- factor(map_chr(str_split(MASTER$file_id, "_"), 1))

MASTER$file_id <- factor(map_chr(str_split(file_names, "_"), 1) [[1]])

str_extract(str_split(file_names, "_")[[1]][1], "[A-Za-z]+")

str_extract([1], "[A-Za-a]+")




map_chr(str_split(MASTER$file_id, "_"), 2)
str_sub(map_chr(str_split(MASTER$file_id, "_"), 2), 1,2)
MASTER$condition <- factor(str_sub(map_chr(str_split(MASTER$file_id, "_"), 2), 1,2))
head(MASTER)

MASTER <- MASTER %>% relocate(file_id, subID, condition)
head(MASTER)

# Export the cleaned PSD data
getwd()


setwd("~/Desktop/TEXTBOOKS & RESOURCES - PhD/FALL 2025/INSTRUMENTATION/PhysTher5110/data")
write.csv(MASTER, "MASTER_EO_and_EC_EEG.csv")




