library(dplyr)
library(stringr)
library(tidyverse)

data <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_cell_count_PAs.csv")


# Assuming the 'raster' field is named 'raster' in the CSV file
# Adjust the column names if necessary after inspecting the data

# Split based on biome prefix (F1, F2, F3, FM1, etc.)
data <- data %>%
  mutate(biome = str_extract(Raster, "^[^_]+"))

### add a category column with wdpa or oecm
data <- data %>%
  mutate(
    category = case_when(
      str_detect(Raster, "wdpa") ~ "wdpa",
      str_detect(Raster, "wdoecm") ~ "oecm",
      TRUE ~ "other"
    )
  )

### add a year column
data <- data %>%
  mutate(
    year = case_when(
      str_detect(Raster, "statusyr2024") ~ "2024",
      str_detect(Raster, "statusyr2022") ~ "2022",
      str_detect(Raster, "statusyr2020") ~ "2020",
      TRUE ~ "other"
    )
  )


# Combine the values using paste
data <- data %>%
  mutate(cat_year = paste(category, year, sep = ""))


# Create the pivot table
pivot_table <- data %>%
  group_by(biome, cat_year) %>%
  summarise(Value = sum(Value_1, na.rm = TRUE)) %>%
  pivot_wider(names_from = cat_year, values_from = Value, values_fill = list(Value = 0))



######### read in global biome pixel counts
biome_global <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_cell_count.csv")

# Split based on biome prefix (F1, F2, F3, FM1, etc.)
biome_global <- biome_global %>%
  mutate(biome = str_extract(Raster, "^[^_]+"))

## select columns we want
biome_global <- subset(biome_global, select = c(biome, Value_1))
## rename Value_1 field
names(biome_global)[names(biome_global) == "Value_1"] <- "biome_count"

####### merge globale biome tavle with PA table

merge <- merge(biome_global, pivot_table)

# Columns to set to zero if biome_global is 0 (NODATA values is set to 1 if there are only zeros in the raster)
columns_to_modify <- c("oecm2020", "oecm2022", "oecm2024", "wdpa2024", "wdpa2022", "wdpa2020") 

# Ensure biome_count is numeric
merge$biome_count <- as.numeric(merge$biome_count)

# Ensure columns to modify are numeric
merge[columns_to_modify] <- lapply(merge[columns_to_modify], as.numeric)

# Modify the columns
merge <- merge %>%
  mutate(across(all_of(columns_to_modify), ~ if_else(biome_count == 0, as.numeric(0), .)))

### calculate area coverage (grid cell is 835.19 x 835.19 which is 0.6975 km²)
merge$biome_area <- merge$biome_count*0.6975
merge$wdpa24_area <- merge$wdpa2024*0.6975
merge$wdpa22_area <- merge$wdpa2022*0.6975
merge$wdpa20_area <- merge$wdpa2020*0.6975
merge$oecm24_area <- merge$oecm2024*0.6975
merge$oecm22_area <- merge$oecm2022*0.6975
merge$oecm20_area <- merge$oecm2020*0.6975

### calculate percentage coverage
merge$wdpa24_perc <- (merge$wdpa2024/merge$biome_count)*100
merge$wdpa22_perc <- (merge$wdpa2022/merge$biome_count)*100
merge$wdpa20_perc <- (merge$wdpa2020/merge$biome_count)*100
merge$oecm24_perc <- (merge$oecm2024/merge$biome_count)*100
merge$oecm22_perc <- (merge$oecm2022/merge$biome_count)*100
merge$oecm20_perc <- (merge$oecm2020/merge$biome_count)*100

## add PA + OECM coverage field
merge$pa_oecm_area24 <- rowSums(merge[c("wdpa24_area", "oecm2024")], na.rm = TRUE)
merge$pa_oecm_area22 <- rowSums(merge[c("wdpa22_area", "oecm2022")], na.rm = TRUE)
merge$pa_oecm_area20 <- rowSums(merge[c("wdpa20_area", "oecm2020")], na.rm = TRUE)

merge$pa_oecm_perc24 <- rowSums(merge[c("wdpa24_perc", "oecm24_perc")], na.rm = TRUE)
merge$pa_oecm_perc22 <- rowSums(merge[c("wdpa22_perc", "oecm22_perc")], na.rm = TRUE)
merge$pa_oecm_perc20 <- rowSums(merge[c("wdpa20_perc", "oecm20_perc")], na.rm = TRUE)


write.csv(merge, "O:/PP2024/chapter5_final/biome/biome_output_tables/biome_transform.csv", row.names = FALSE, fileEncoding = "CP1252")
