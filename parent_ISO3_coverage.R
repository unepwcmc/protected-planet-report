library(dplyr)

pa <- read.csv("Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/pa_oecm_national.csv")
parent <- read.csv("O:/PP2024/ISO3_to_parent_ISO3.csv")

## add paremt ISO
pa_parent <- merge(pa, parent, by = "ISO3", all.x = TRUE)

parent_pivot <- pa_parent %>%
  group_by(PARENT_ISO3) %>%
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

parent_pivot$pa_land_percent <- (parent_pivot$pa_land_area/parent_pivot$land_area)*100
parent_pivot$pa_marine_percent <- (parent_pivot$pa_marine_area/parent_pivot$marine_area)*100

parent_pivot$oecm_land_percent <- (parent_pivot$oecm_land_area/parent_pivot$land_area)*100
parent_pivot$oecm_marine_percent <- (parent_pivot$oecm_marine_area/parent_pivot$marine_area)*100

parent_pivot$pa_oecm_land_percent <- (parent_pivot$pa_oecm_land_area/parent_pivot$land_area)*100
parent_pivot$pa_oecm_marine_percent <- (parent_pivot$pa_oecm_marine_area/parent_pivot$marine_area)*100

write.csv(parent_pivot, "Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/national_stats/pa_oecm_national_parent_ISO3.csv")


######### now by subreagions

## read in region crosswalk
regions <- read.csv("O:/PP2024/ISO_regions.csv")

### merge pa oecm with reagions
pa_parent <- merge(pa_parent, regions, by.x="PARENT_ISO3", by.y="iso3cd", all.x=TRUE)


region_pivot <- pa_parent %>%
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

write.csv(region_pivot, "Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/3_Coverage/regional_stats/pa_oecm_regional_parent_ISO3.csv")
