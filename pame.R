pame <- read.csv("Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/7_Effectiveness/2_PAME/pame_national.csv")

## read in region crosswalk
regions <- read.csv("O:/PP2024/ISO_regions.csv")

### merge pa oecm with reagions
pame <- merge(pame, regions, by.x="ISO3", by.y="iso3cd", all.x=TRUE)


region_pivot <- pame %>%
  group_by(Sub_region_Name) %>%
  summarise(
    land_area = sum(land_area, na.rm = TRUE),
    marine_area = sum(marine_area, na.rm = TRUE),
    pame_pa_land_area = sum(pame_pa_land_area, na.rm = TRUE),
    pame_pa_marine_area = sum(pame_pa_marine_area, na.rm = TRUE)
  )

region_pivot$pame_land_percent <- (region_pivot$pame_pa_land_area/region_pivot$land_area)*100
region_pivot$pame_marine_percent <- (region_pivot$pame_pa_marine_area/region_pivot$marine_area)*100

write.csv(region_pivot, "Z:/f01_projects_active/Global/p08942_Protected_Planet_2024/outputs/7_Effectiveness/2_PAME/pame_subregional.csv")
