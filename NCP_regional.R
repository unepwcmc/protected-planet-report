library(foreign)
library(dplyr)

potential <- read.csv("O:/PP2024/chapter4_final/NCP/tables/potential_ncp_cell_count_national.csv")
realized <- read.csv("O:/PP2024/chapter4_final/NCP/tables/realized_ncp_cell_count_national.csv")

potential <- subset(potential, select = c(iso3cd,SUM))
realized <- subset(realized, select = c(iso3cd,SUM))
names(potential)[names(potential) == "SUM"] <- "potential_count"
names(realized)[names(realized) == "SUM"] <- "realized_count"



########### read all tables in within a folder
# Set the folder path
folder_path <- "O:/PP2024/chapter4_final/NCP/tables"

# List all DBF files
dbf_files <- list.files(path = folder_path, pattern = "\\.dbf$", full.names = TRUE)


for (file in dbf_files) {
  # Extract the file name without extension
  df_name <- tools::file_path_sans_ext(basename(file))
  
  # Read the DBF file
  df <- read.dbf(file)
  
  # Assign the data frame to a variable in the global environment
  assign(df_name, df)
}



### remove unwanted columns and rename count column
#potential_oecm_2020 <- subset(potential_oecm_2020, select = c(iso3cd,SUM))

names(potential_oecm_2020)[names(potential_oecm_2020) == "SUM"] <- "potential_oecm_2020_count"
names(potential_oecm_2022)[names(potential_oecm_2022) == "SUM"] <- "potential_oecm_2022_count"
names(potential_oecm_2024)[names(potential_oecm_2024) == "SUM"] <- "potential_oecm_2024_count"

names(potential_wdpa_2020)[names(potential_wdpa_2020) == "SUM"] <- "potential_wdpa_2020_count"
names(potential_wdpa_2022)[names(potential_wdpa_2022) == "SUM"] <- "potential_wdpa_2022_count"
names(potential_wdpa_2024)[names(potential_wdpa_2024) == "SUM"] <- "potential_wdpa_2024_count"

names(realized_oecm_2020)[names(realized_oecm_2020) == "SUM"] <- "realized_oecm_2020_count"
names(realized_oecm_2022)[names(realized_oecm_2022) == "SUM"] <- "realized_oecm_2022_count"
names(realized_oecm_2024)[names(realized_oecm_2024) == "SUM"] <- "realized_oecm_2024_count"

names(realized_wdpa_2020)[names(realized_wdpa_2020) == "SUM"] <- "realized_wdpa_2020_count"
names(realized_wdpa_2022)[names(realized_wdpa_2022) == "SUM"] <- "realized_wdpa_2022_count"
names(realized_wdpa_2024)[names(realized_wdpa_2024) == "SUM"] <- "realized_wdpa_2024_count"


###### merge tables

#### list tables to be merged
df_list <- list(potential, realized, 
                potential_oecm_2020, potential_oecm_2022, potential_oecm_2024, 
                potential_wdpa_2020, potential_wdpa_2022, potential_wdpa_2024,
                realized_oecm_2020, realized_oecm_2022, realized_oecm_2024,
                realized_wdpa_2020, realized_wdpa_2022, realized_wdpa_2024)

### merge tables in list
merged_df <- Reduce(function(x, y) merge(x, y, by = "iso3cd", all = TRUE), df_list)

### remove unwanted columns
merged_df <- subset(merged_df, select = c(iso3cd,potential_count, realized_count,
                                          potential_oecm_2020_count, potential_oecm_2022_count, potential_oecm_2024_count,
                                          potential_wdpa_2020_count, potential_wdpa_2022_count, potential_wdpa_2024_count,
                                          realized_oecm_2020_count, realized_oecm_2022_count, realized_oecm_2024_count,
                                          realized_wdpa_2020_count, realized_wdpa_2022_count, realized_wdpa_2024_count))

##### add these values to a subregion folder lor later 
subregion <- merged_df


#### calculate global stats by summing regions
# Calculate the sum of all rows for each column except the first one (GEOandUNEP)
sum_row <- colSums(merged_df[, -1], na.rm = TRUE)

# Add the 'global' row to the data frame
merged_df[nrow(merged_df) + 1, ] <- c("global", sum_row)

merged_df[, -1] <- lapply(merged_df[, -1], as.numeric) ## make all columns numeric

##### add area columns. Grid cells are 5km x 5km = 25km2. therefore cell count is multiplied by 25
merged_df$potential_km2 <- merged_df$potential_count*25
merged_df$realized_km2 <- merged_df$realized_count*25


merged_df$potential_oecm_2020_km2 <- merged_df$potential_oecm_2020_count*25
merged_df$potential_oecm_2022_km2 <- merged_df$potential_oecm_2022_count*25
merged_df$potential_oecm_2024_km2 <- merged_df$potential_oecm_2024_count*25

merged_df$potential_wdpa_2020_km2 <- merged_df$potential_wdpa_2020_count*25
merged_df$potential_wdpa_2022_km2 <- merged_df$potential_wdpa_2022_count*25
merged_df$potential_wdpa_2024_km2 <- merged_df$potential_wdpa_2024_count*25

merged_df$realized_oecm_2020_km2 <- merged_df$realized_oecm_2020_count*25
merged_df$realized_oecm_2022_km2 <- merged_df$realized_oecm_2022_count*25
merged_df$realized_oecm_2024_km2 <- merged_df$realized_oecm_2024_count*25

merged_df$realized_wdpa_2020_km2 <- merged_df$realized_wdpa_2020_count*25
merged_df$realized_wdpa_2022_km2 <- merged_df$realized_wdpa_2022_count*25
merged_df$realized_wdpa_2024_km2 <- merged_df$realized_wdpa_2024_count*25


##### add percentage columns

merged_df$potential_oecm_2020_perc <- (merged_df$potential_oecm_2020_count/merged_df$potential_count)*100
merged_df$potential_oecm_2022_perc <- (merged_df$potential_oecm_2022_count/merged_df$potential_count)*100
merged_df$potential_oecm_2024_perc <- (merged_df$potential_oecm_2024_count/merged_df$potential_count)*100

merged_df$potential_wdpa_2020_perc <- (merged_df$potential_wdpa_2020_count/merged_df$potential_count)*100
merged_df$potential_wdpa_2022_perc <- (merged_df$potential_wdpa_2022_count/merged_df$potential_count)*100
merged_df$potential_wdpa_2024_perc <- (merged_df$potential_wdpa_2024_count/merged_df$potential_count)*100

merged_df$realized_oecm_2020_perc <- (merged_df$realized_oecm_2020_count/merged_df$realized_count)*100
merged_df$realized_oecm_2022_perc <- (merged_df$realized_oecm_2022_count/merged_df$realized_count)*100
merged_df$realized_oecm_2024_perc <- (merged_df$realized_oecm_2024_count/merged_df$realized_count)*100

merged_df$realized_wdpa_2020_perc <- (merged_df$realized_wdpa_2020_count/merged_df$realized_count)*100
merged_df$realized_wdpa_2022_perc <- (merged_df$realized_wdpa_2022_count/merged_df$realized_count)*100
merged_df$realized_wdpa_2024_perc <- (merged_df$realized_wdpa_2024_count/merged_df$realized_count)*100

########## join region names
region_names <- read.csv("O:/PP2024/chapter4_final/ISO_to_subregion.csv")

merged_df <- merge(merged_df, region_names, by = "iso3cd", all.x = TRUE)

######### filter out national and global and write to csv
national <- merged_df %>% filter(iso3cd != "global")
global <- merged_df %>% filter(iso3cd == "global")

write.csv(national, "O:/PP2024/chapter4_final/NCP/final_stats/national_ncp.csv")
write.csv(global, "O:/PP2024/chapter4_final/NCP/final_stats/global_ncp.csv")

####### sum by subregion

subregion <- merge(subregion, region_names, by = "iso3cd", all.x = TRUE)

subregion <- subregion %>%
  group_by(Sub_region_Name) %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE))


##### add area columns. Grid cells are 5km x 5km = 25km2. therefore cell count is multiplied by 25
subregion$potential_km2 <- subregion$potential_count*25
subregion$realized_km2 <- subregion$realized_count*25


subregion$potential_oecm_2020_km2 <- subregion$potential_oecm_2020_count*25
subregion$potential_oecm_2022_km2 <- subregion$potential_oecm_2022_count*25
subregion$potential_oecm_2024_km2 <- subregion$potential_oecm_2024_count*25

subregion$potential_wdpa_2020_km2 <- subregion$potential_wdpa_2020_count*25
subregion$potential_wdpa_2022_km2 <- subregion$potential_wdpa_2022_count*25
subregion$potential_wdpa_2024_km2 <- subregion$potential_wdpa_2024_count*25

subregion$realized_oecm_2020_km2 <- subregion$realized_oecm_2020_count*25
subregion$realized_oecm_2022_km2 <- subregion$realized_oecm_2022_count*25
subregion$realized_oecm_2024_km2 <- subregion$realized_oecm_2024_count*25

subregion$realized_wdpa_2020_km2 <- subregion$realized_wdpa_2020_count*25
subregion$realized_wdpa_2022_km2 <- subregion$realized_wdpa_2022_count*25
subregion$realized_wdpa_2024_km2 <- subregion$realized_wdpa_2024_count*25


##### add percentage columns

subregion$potential_oecm_2020_perc <- (subregion$potential_oecm_2020_count/subregion$potential_count)*100
subregion$potential_oecm_2022_perc <- (subregion$potential_oecm_2022_count/subregion$potential_count)*100
subregion$potential_oecm_2024_perc <- (subregion$potential_oecm_2024_count/subregion$potential_count)*100

subregion$potential_wdpa_2020_perc <- (subregion$potential_wdpa_2020_count/subregion$potential_count)*100
subregion$potential_wdpa_2022_perc <- (subregion$potential_wdpa_2022_count/subregion$potential_count)*100
subregion$potential_wdpa_2024_perc <- (subregion$potential_wdpa_2024_count/subregion$potential_count)*100

subregion$realized_oecm_2020_perc <- (subregion$realized_oecm_2020_count/subregion$realized_count)*100
subregion$realized_oecm_2022_perc <- (subregion$realized_oecm_2022_count/subregion$realized_count)*100
subregion$realized_oecm_2024_perc <- (subregion$realized_oecm_2024_count/subregion$realized_count)*100

subregion$realized_wdpa_2020_perc <- (subregion$realized_wdpa_2020_count/subregion$realized_count)*100
subregion$realized_wdpa_2022_perc <- (subregion$realized_wdpa_2022_count/subregion$realized_count)*100
subregion$realized_wdpa_2024_perc <- (subregion$realized_wdpa_2024_count/subregion$realized_count)*100

write.csv(subregion, "O:/PP2024/chapter4_final/NCP/final_stats/subregion_ncp.csv")

