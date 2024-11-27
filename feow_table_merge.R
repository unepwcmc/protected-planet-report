eco <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/feow_names.csv", fileEncoding = "UTF-8-BOM")
wdpa24 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/wdpa24_feow_intersect.csv", fileEncoding = "UTF-8-BOM")
wdpa22 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/wdpa22_feow_intersect.csv", fileEncoding = "UTF-8-BOM")
wdpa20 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/wdpa20_feow_intersect.csv", fileEncoding = "UTF-8-BOM")
oecm24 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/oecm24_feow_intersect.csv", fileEncoding = "UTF-8-BOM")
oecm22 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/oecm22_feow_intersect.csv", fileEncoding = "UTF-8-BOM")
oecm20 <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/oecm20_feow_intersect.csv", fileEncoding = "UTF-8-BOM")

### remove unwanted columns and rename area column
wdpa24 <- subset(wdpa24, select = c(FEOW_ID, SUM_area_km2))
names(wdpa24)[names(wdpa24) == "SUM_area_km2"] <- "wdpa24_area"

wdpa22 <- subset(wdpa22, select = c(FEOW_ID, SUM_area_km2))
names(wdpa22)[names(wdpa22) == "SUM_area_km2"] <- "wdpa22_area"

wdpa20 <- subset(wdpa20, select = c(FEOW_ID, SUM_area_km2))
names(wdpa20)[names(wdpa20) == "SUM_area_km2"] <- "wdpa20_area"

oecm24 <- subset(oecm24, select = c(FEOW_ID, SUM_area_km2))
names(oecm24)[names(oecm24) == "SUM_area_km2"] <- "oecm24_area"

oecm22 <- subset(oecm22, select = c(FEOW_ID, SUM_area_km2))
names(oecm22)[names(oecm22) == "SUM_area_km2"] <- "oecm22_area"

oecm20 <- subset(oecm20, select = c(FEOW_ID, SUM_area_km2))
names(oecm20)[names(oecm20) == "SUM_area_km2"] <- "oecm20_area"


### Merge tables
merge <- merge(eco, wdpa24, by = "FEOW_ID", all.x = TRUE)
merge <- merge(merge, wdpa22, by = "FEOW_ID", all.x = TRUE)
merge <- merge(merge, wdpa20, by = "FEOW_ID", all.x = TRUE)
merge <- merge(merge, oecm24, by = "FEOW_ID", all.x = TRUE)
merge <- merge(merge, oecm22, by = "FEOW_ID", all.x = TRUE)
merge <- merge(merge, oecm20, by = "FEOW_ID", all.x = TRUE)

### calculate percentage coverage
merge$wdpa24_perc <- (merge$wdpa24_area/merge$feow_area)*100
merge$wdpa22_perc <- (merge$wdpa22_area/merge$feow_area)*100
merge$wdpa20_perc <- (merge$wdpa20_area/merge$feow_area)*100
merge$oecm24_perc <- (merge$oecm24_area/merge$feow_area)*100
merge$oecm22_perc <- (merge$oecm22_area/merge$feow_area)*100
merge$oecm20_perc <- (merge$oecm20_area/merge$feow_area)*100

## add PA + OECM coverage field
merge$pa_oecm_area24 <- rowSums(merge[c("wdpa24_area", "oecm24_area")], na.rm = TRUE)
merge$pa_oecm_area22 <- rowSums(merge[c("wdpa22_area", "oecm22_area")], na.rm = TRUE)
merge$pa_oecm_area20 <- rowSums(merge[c("wdpa20_area", "oecm20_area")], na.rm = TRUE)

merge$pa_oecm_perc24 <- rowSums(merge[c("wdpa24_perc", "oecm24_perc")], na.rm = TRUE)
merge$pa_oecm_perc22 <- rowSums(merge[c("wdpa22_perc", "oecm22_perc")], na.rm = TRUE)
merge$pa_oecm_perc20 <- rowSums(merge[c("wdpa20_perc", "oecm20_perc")], na.rm = TRUE)


write.csv(merge, "C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/feow_merge_table.csv", row.names = FALSE, fileEncoding = "CP1252")
