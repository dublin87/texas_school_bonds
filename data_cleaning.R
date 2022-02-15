#################################################
# Nick Messenger 
# Created February 9, 2022
#################################################


##########################
# Package Management
##########################

install.packages("pacman")

packages_v <- c("here", "tidyverse", "sf", "rvest", "jsonlite",    
                "httr", "pacman", "tictoc", "pryr", "tigris", "tidycensus","rgdal","Matching", 
                "raster", "stargazer") 
pacman::p_load(char = packages_v)

# Set Working Directory 
setwd("C:/Users/messenger.37/Documents/R Projects/texas_school_bonds")

#### Load census API key 
census_api_key("1d2602068db46e014dbf54a7c7e195cb8f417e61", install = TRUE, overwrite = TRUE)

#### Read bond data
bonds <- as.data.frame(read.csv("Data/raw_bonds.csv"))
bonds$IssuerName <- toupper(bonds$IssuerName)



type.master <- as.data.frame(read.csv("Data/district_type.csv"))
district_profile_2020 <- as.data.frame(read.csv("Data/distprofile2020.csv"))

### Rename columns to prepare datasets for merge. 
colnames(type.master)[1] <- "IssuerName"
colnames(district_profile_2020)[2] <- "District.Number"

combine <- merge(bonds, type.master, by="IssuerName")
combine2 <- merge(combine, district_profile_2020, by = "District.Number")
combine3 <- merge(type.master, district_profile_2020, by = "District.Number")

write.csv(combine3, "district_data.csv")

suburban <- filter(combine2, TEA.Description== "Major Suburban")


peerbonds <- bonds%>%
  filter(IssuerName %in% y$IssuerName)




### Shapefiles

district.map.data <- as.data.frame(read.csv("Data/Districts2020to2021.csv"))




#### Get school district census information
texas_income_19 <-get_acs(geography = "school district (unified)",
                       year = 2019,
                       variables = "B19013_001",
                       state = "TX")

