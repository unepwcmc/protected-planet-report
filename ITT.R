eco <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_terr/eco_terr_output_tables/Ecoregions2017_merge_table.csv", fileEncoding = "CP1252")
itt <- read.csv("O:/PP2024/chapter9_ITTs/ITT_ecoregion.csv")
gov <- read.csv("O:/PP2024/chapter9_ITTs/ITT_ecoregion_ackbygov_pivot.csv")

merge <- merge(eco, itt, by = "ECO_ID", all = TRUE)
merge <- merge(merge, gov, by = "ECO_ID", all = TRUE)

merge <- subset(merge, select = c(ECO_ID, ECO_NAME, ECO_area, wdpa24_area, oecm24_area, wdpa24_perc, oecm24_perc, pa_oecm_area24, pa_oecm_perc24, ITT_area, ackbygov_area))

merge$ITT_perc <- (merge$ITT_area/merge$ECO_area)*100
merge$ackbygov_perc <- (merge$ackbygov_area/merge$ECO_area)*100



merge$pa_oecm24_ITT_area <- rowSums(merge[c("wdpa24_area", "oecm24_area", "ITT_area")], na.rm = TRUE)
merge$pa_oecm24_ITT_perc <- (merge$pa_oecm24_ITT_area/merge$ECO_area)*100

merge$pa_oecm24_ackgybov_area <- rowSums(merge[c("wdpa24_area", "oecm24_area", "ackbygov_area")], na.rm = TRUE)
merge$pa_oecm24_ackgybov_perc <- (merge$pa_oecm24_ackgybov_area/merge$ECO_area)*100

write.csv(merge, "O:/PP2024/chapter9_ITTs/ITT_ecoregion_percentage.csv")
