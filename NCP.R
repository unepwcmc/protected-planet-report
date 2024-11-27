
ncp_global <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/NCP/output_tables/ncp_cell_count.csv", fileEncoding = "UTF-8-BOM")
ncp_pa <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/NCP/output_tables/ncp_cell_count_PAs.csv", fileEncoding = "UTF-8-BOM")



## add a potential and relized field
ncp_global$ncp <- c("potential", "realized")
ncp_pa$ncp <- c(rep("potential", 6), rep("realized", 6))

### add a category column with wdpa or oecm
ncp_pa <- ncp_pa %>%
  mutate(
    category = case_when(
      str_detect(Raster, "wdpa") ~ "wdpa",
      str_detect(Raster, "wdoecm") ~ "oecm",
      TRUE ~ "other"
    )
  )

### add a year column
ncp_pa <- ncp_pa %>%
  mutate(
    year = case_when(
      str_detect(Raster, "statusyr2024") ~ "2024",
      str_detect(Raster, "statusyr2022") ~ "2022",
      str_detect(Raster, "statusyr2020") ~ "2020",
      TRUE ~ "other"
    )
  )


# Combine the values using paste
ncp_pa <- ncp_pa %>%
  mutate(cat_year = paste(category, year, sep = ""))

### remove unwanted columns and rename count column
ncp_global <- subset(ncp_global, select = c(ncp,Value_1))
names(ncp_global)[names(ncp_global) == "Value_1"] <- "global_count"


# Create the pivot table
pivot_table <- ncp_pa %>%
  group_by(ncp, cat_year) %>%
  summarise(Value = sum(Value_1, na.rm = TRUE)) %>%
  pivot_wider(names_from = cat_year, values_from = Value, values_fill = list(Value = 0))

## merge tables
merge <- merge(ncp_global, pivot_table, by = "ncp", all.x = TRUE)

## calculate percentage cover
merge$perc <- (merge$pa_count/merge$global_count)*100

### calculate percentage coverage
merge$wdpa24_perc <- (merge$wdpa2024/merge$global_count)*100
merge$wdpa22_perc <- (merge$wdpa2022/merge$global_count)*100
merge$wdpa20_perc <- (merge$wdpa2020/merge$global_count)*100
merge$oecm24_perc <- (merge$oecm2024/merge$global_count)*100
merge$oecm22_perc <- (merge$oecm2022/merge$global_count)*100
merge$oecm20_perc <- (merge$oecm2020/merge$global_count)*100

write.csv(merge, "C:/Users/JoeG/OneDrive - WCMC/PP2024/NCP/output_tables/chapter4_NCP.csv")
