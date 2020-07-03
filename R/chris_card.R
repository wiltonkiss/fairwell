library(dplyr)

get_name <- function(x){
  #depricated, but I wrote the function so I'm leaving it in
  name <- toupper(x) %>% 
    stringr::str_replace("MESSAGE", "") %>%
    stringr::str_replace(".TXT", "") %>%
    stringr::str_replace("_", " ") %>%
    stringr::str_replace("-", "") %>%
    trimws("r") %>% 
    tolower()
  
  paste0(toupper(substring(name, 1, 1)), substring(name, 2, nchar(name)))
}

get_message <- function(x, loc) {
  
  readLines(file.path(paste0(loc, x)), warn=FALSE) %>%
    paste(., collapse = "<br>")
}


loc <- "../data/"
all_files <- list.files(loc)
text_files <- all_files[stringr::str_detect(all_files, ".txt")]
image_files <- all_files[stringr::str_detect(all_files, ".jpg")]

text_colours <- c("#00bfff",
                  "#0080ff",	
                  "#0040ff",	
                  "#0000ff",
                  "#4000ff",
                  "#8000ff",
                  "#bf00ff",
                  "#ff00ff",
                  "#ff00bf",
                  "#ff0080",
                  "#ff0040",
                  "#ff0000")

messages <- as.character()
for(i in 1:length(text_files)){
  messages[i]  <- paste0("<p style=\"color:",text_colours[sample(1:12,1)],"\"><b>",get_message(text_files[i], loc),"</b></p>")
  name <- get_name(text_files[[i]])
}

mgs <- list()
a <- "</p><p><br><p>"
mgs[[1]] <- paste(messages[1:4],a,collapse = a)
mgs[[2]] <- paste(messages[5:8],a,collapse = a)
mgs[[3]] <- paste(messages[9:12],a,collapse = a)
mgs[[4]] <- paste(messages[13:16],a,collapse = a)
mgs[[5]] <- paste(messages[17:20],a,collapse = a)
mgs[[6]] <- paste(messages[21:100][!is.na(messages[21:100])],a,collapse = a)

dir.create(paste0(loc,"processed"), showWarnings = FALSE)
for(i in 1:6){
  write.table(mgs[[i]], paste0(loc,"processed/messages_",i,".html"), col.names=F, row.names = F, quote = F)
}

#images
image_files <- all_files[stringr::str_detect(all_files, ".jpg")]
image_names <- stringr::str_replace(image_files, ".jpg", "")

#random very important variable
x <- 1