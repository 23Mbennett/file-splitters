

library(tidyverse)
library(lubridate)


############## File Splitting Weather Data for Upload ###############

weather <- read_csv("C:/Users/bam5/Desktop/data_downtown_all.csv") %>% select(-1,)

weather <- weather %>% 
      mutate(doy = yday(datetime))



##Subset data put each day in large list ##

list1 <- list()

for(i in 1:length(unique(weather$doy))) {
  
  list1[[i]] <- weather %>% filter(doy == unique(weather$doy)[i]) %>% select(-doy)
  
}



##make root path##
path <- "C:/Users/bam5/Desktop/Weather Data/"



##MAKE REPOS##
for(i in 1:length(list1)) {
 
  dir.create(paste0(path, as.character(year(list1[[i]]$datetime[1]))))
  
  dir.create(paste0(path, as.character(year(list1[[i]]$datetime[1])), "/", as.character(month(list1[[i]]$datetime[1]))))
  
  dir.create(paste0(path, as.character(year(list1[[i]]$datetime[1])), "/", as.character(month(list1[[i]]$datetime[1])), "/", as.character(day(list1[[i]]$datetime[1]))))
 
   
}  

  


##write CSVS In REPOS##
for(i in 1:length(list1)) {  
  write.csv(list1[[i]], paste0(path,
                               year((list1[[i]]$datetime[1])),
                               "/",
                               month((list1[[i]]$datetime[1])),
                               "/",
                               day((list1[[i]]$datetime[1])),
                               "/",
                               "weather",
                               ".csv")
  )
  
}



