library(dplyr)

pa <- read.csv("Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/b_national_statistics.csv")
oecm <- read.csv("Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/b_national_statistics_oecm.csv")

## merge pa and oecm
pa_oecm <- merge(pa, oecm, by="ISO3", all = TRUE)

## sum and make % for pa and oecm
pa_oecm$pa_oecm_land_area <- rowSums(pa_oecm[c("pa_land_area", "oecm_land_area")], na.rm = TRUE)
pa_oecm$pa_oecm_land_percent <- (pa_oecm$pa_oecm_land_area/pa_oecm$land_area)*100

pa_oecm$pa_oecm_marine_area <- rowSums(pa_oecm[c("pa_marine_area", "oecm_marine_area")], na.rm = TRUE)
pa_oecm$pa_oecm_marine_percent <- (pa_oecm$pa_oecm_marine_area/pa_oecm$marine_area)*100

## write national file
write.csv(pa_oecm, "Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/pa_oecm_national.csv")

############################ sub regional
## read in region crosswalk
regions <- read.csv("O:/PP2024/ISO_regions.csv")

### merge pa oecm with reagions
pa_oecm <- merge(pa_oecm, regions, by.x="ISO3", by.y="iso3cd", all.x=TRUE)


region_pivot <- pa_oecm %>%
  group_by(Sub_region_Name) %>%
  summarise(
    land_area = sum(land_area, na.rm = TRUE),
    marine_area = sum(marine_area, na.rm = TRUE),
    pa_land_area = sum(pa_land_area, na.rm = TRUE),
    pa_marine_area = sum(pa_marine_area, na.rm = TRUE),
    oecm_land_area = sum(oecm_land_area, na.rm = TRUE),
    oecm_marine_area = sum(oecm_marine_area, na.rm = TRUE),
    pa_oecm_land_area = sum(pa_oecm_land_area, na.rm = TRUE),
    pa_oecm_marine_area = sum(pa_oecm_marine_area, na.rm = TRUE)
  )

region_pivot$pa_land_percent <- (region_pivot$pa_land_area/region_pivot$land_area)*100
region_pivot$pa_marine_percent <- (region_pivot$pa_marine_area/region_pivot$marine_area)*100

region_pivot$oecm_land_percent <- (region_pivot$oecm_land_area/region_pivot$land_area)*100
region_pivot$oecm_marine_percent <- (region_pivot$oecm_marine_area/region_pivot$marine_area)*100

region_pivot$pa_oecm_land_percent <- (region_pivot$pa_oecm_land_area/region_pivot$land_area)*100
region_pivot$pa_oecm_marine_percent <- (region_pivot$pa_oecm_marine_area/region_pivot$marine_area)*100

write.csv(region_pivot, "Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/regional_stats/pa_oecm_regional.csv")

