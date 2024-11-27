library(dplyr)

pa <- read.csv("Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/pa_oecm_national.csv")
itt <- read.csv("O:/PP2024/chapter9_ITTs/ITT_national_ackbygov_pivot.csv")

### merge pas and itts
pa_itt <- merge(pa, itt, by.x = "ISO3", by.y ="iso3cd", all.x = TRUE)

## calculate itt percent and total percent
pa_itt$ITT_percent <- (pa_itt$ITT_area/pa_itt$land_area)*100
pa_itt$pa_oecm_itt_percent <- rowSums(pa_itt[c("pa_oecm_land_percent", "ITT_percent")], na.rm = TRUE)

write.csv(pa_itt, "O:/PP2024/chapter9_ITTs/pa_oecm_ITT_national.csv")


############################ sub regional
## read in region crosswalk
regions <- read.csv("O:/PP2024/ISO_regions.csv")

### merge pa oecm with reagions
pa_itt <- merge(pa_itt, regions, by.x="ISO3", by.y="iso3cd", all.x=TRUE)


region_pivot <- pa_itt %>%
  group_by(Sub_region_Name) %>%
  summarise(
    land_area = sum(land_area, na.rm = TRUE),
    pa_land_area = sum(pa_land_area, na.rm = TRUE),
    oecm_land_area = sum(oecm_land_area, na.rm = TRUE),
    pa_oecm_land_area = sum(pa_oecm_land_area, na.rm = TRUE),
    not_ackbygov = sum(not_ackbygov, na.rm = TRUE),
    ackbygov = sum(ackbygov, na.rm = TRUE),
    ITT_area = sum(ITT_area, na.rm = TRUE),
  )

region_pivot$pa_land_percent <- (region_pivot$pa_land_area/region_pivot$land_area)*100

region_pivot$oecm_land_percent <- (region_pivot$oecm_land_area/region_pivot$land_area)*100

region_pivot$pa_oecm_land_percent <- (region_pivot$pa_oecm_land_area/region_pivot$land_area)*100

region_pivot$ITT_percent <- (region_pivot$ITT_area/region_pivot$land_area)*100

region_pivot$not_ackbygov_percent <- (region_pivot$not_ackbygov/region_pivot$land_area)*100

region_pivot$ackbygov_percent <- (region_pivot$ackbygov/region_pivot$land_area)*100


region_pivot$pa_oecm_itt_percent <- rowSums(region_pivot[c("pa_oecm_land_percent", "ITT_percent")], na.rm = TRUE)
region_pivot$pa_oecm_not_ackbygov_percent <- rowSums(region_pivot[c("pa_oecm_land_percent", "not_ackbygov_percent")], na.rm = TRUE)
region_pivot$pa_oecm_ackbygov_percent <- rowSums(region_pivot[c("pa_oecm_land_percent", "ackbygov_percent")], na.rm = TRUE)


write.csv(region_pivot, "O:/PP2024/chapter9_ITTs/pa_oecm_ITT_regional_ackbygov.csv")

