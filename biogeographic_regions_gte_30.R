library(dplyr)

########### terrestrial ecoregions ###########################################################################################################
eco <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_terr/eco_terr_output_tables/Ecoregions2017_merge_table.csv")

### count number of ecoregions >= 30% coverage
eco_gte_30 <- eco %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
eco_gte_30$OECM_addition_2024 <- eco_gte_30$PA_OECM_2024 - eco_gte_30$PA_2024
eco_gte_30$OECM_addition_2022 <- eco_gte_30$PA_OECM_2022 - eco_gte_30$PA_2022
eco_gte_30$OECM_addition_2020 <- eco_gte_30$PA_OECM_2020 - eco_gte_30$PA_2020

## calculate percentage
eco_gte_30$PA_2024_perc <- (eco_gte_30$PA_2024/847)*100
eco_gte_30$PA_2022_perc <- (eco_gte_30$PA_2022/847)*100
eco_gte_30$PA_2020_perc <- (eco_gte_30$PA_2020/847)*100
eco_gte_30$OECM_addition_2024_perc <- (eco_gte_30$OECM_addition_2024/847)*100
eco_gte_30$OECM_addition_2022_perc <- (eco_gte_30$OECM_addition_2022/847)*100
eco_gte_30$OECM_addition_2020_perc <- (eco_gte_30$OECM_addition_2020/847)*100

eco_gte_30$biogeographical_unit <- "ecoregions"
eco_gte_30$realm <- "terrestrial"

############ marine ecoregions ###########################################################################################################
marine_eco <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_marine/eco_marine_output_tables/MEOW_merge_table.csv")
## remove rows that are not ecoregions
marine_eco <- marine_eco %>%
  filter(!is.na(ECOREGION))

### count number of ecoregions >= 30% coverage
marine_eco_gte_30 <- marine_eco %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
marine_eco_gte_30$OECM_addition_2024 <- marine_eco_gte_30$PA_OECM_2024 - marine_eco_gte_30$PA_2024
marine_eco_gte_30$OECM_addition_2022 <- marine_eco_gte_30$PA_OECM_2022 - marine_eco_gte_30$PA_2022
marine_eco_gte_30$OECM_addition_2020 <- marine_eco_gte_30$PA_OECM_2020 - marine_eco_gte_30$PA_2020

## calculate percentage
marine_eco_gte_30$PA_2024_perc <- (marine_eco_gte_30$PA_2024/232)*100
marine_eco_gte_30$PA_2022_perc <- (marine_eco_gte_30$PA_2022/232)*100
marine_eco_gte_30$PA_2020_perc <- (marine_eco_gte_30$PA_2020/232)*100
marine_eco_gte_30$OECM_addition_2024_perc <- (marine_eco_gte_30$OECM_addition_2024/232)*100
marine_eco_gte_30$OECM_addition_2022_perc <- (marine_eco_gte_30$OECM_addition_2022/232)*100
marine_eco_gte_30$OECM_addition_2020_perc <- (marine_eco_gte_30$OECM_addition_2020/232)*100

marine_eco_gte_30$biogeographical_unit <- "ecoregions"
marine_eco_gte_30$realm <- "marine"

########## freshwater ecoregions #########################################################################################################
fresh_eco <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_freshwater/eco_fresh_output_tables/feow_merge_table.csv")

### count number of freshwater ecoregions >= 30% coverage
fresh_eco_gte_30 <- fresh_eco %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
fresh_eco_gte_30$OECM_addition_2024 <- fresh_eco_gte_30$PA_OECM_2024 - fresh_eco_gte_30$PA_2024
fresh_eco_gte_30$OECM_addition_2022 <- fresh_eco_gte_30$PA_OECM_2022 - fresh_eco_gte_30$PA_2022
fresh_eco_gte_30$OECM_addition_2020 <- fresh_eco_gte_30$PA_OECM_2020 - fresh_eco_gte_30$PA_2020

## calculate percentage
fresh_eco_gte_30$PA_2024_perc <- (fresh_eco_gte_30$PA_2024/449)*100
fresh_eco_gte_30$PA_2022_perc <- (fresh_eco_gte_30$PA_2022/449)*100
fresh_eco_gte_30$PA_2020_perc <- (fresh_eco_gte_30$PA_2020/449)*100
fresh_eco_gte_30$OECM_addition_2024_perc <- (fresh_eco_gte_30$OECM_addition_2024/449)*100
fresh_eco_gte_30$OECM_addition_2022_perc <- (fresh_eco_gte_30$OECM_addition_2022/449)*100
fresh_eco_gte_30$OECM_addition_2020_perc <- (fresh_eco_gte_30$OECM_addition_2020/449)*100

fresh_eco_gte_30$biogeographical_unit <- "ecoregions"
fresh_eco_gte_30$realm <- "freshwater"



############ marine provinces ###########################################################################################################
marine_prov <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_marine/eco_marine_output_tables/MEOW_merge_table.csv")
## select marine provinces
marine_prov <- marine_prov %>%
  filter(TYPE == "MEOW")

# Sum values in columns by province
marine_prov_sum <- marine_prov %>%
  group_by(PROVINC) %>%
  summarise(
    prov_area = sum(meow_area, na.rm = TRUE),
    wdpa24_area = sum(wdpa24_area, na.rm = TRUE),
    wdpa22_area = sum(wdpa22_area, na.rm = TRUE),
    wdpa20_area = sum(wdpa20_area, na.rm = TRUE),
    oecm24_area = sum(oecm24_area, na.rm = TRUE),
    oecm22_area = sum(oecm22_area, na.rm = TRUE),
    oecm20_area = sum(oecm20_area, na.rm = TRUE)
  )

### calculate percentage coverage
marine_prov_sum$wdpa24_perc <- (marine_prov_sum$wdpa24_area/marine_prov_sum$prov_area)*100
marine_prov_sum$wdpa22_perc <- (marine_prov_sum$wdpa22_area/marine_prov_sum$prov_area)*100
marine_prov_sum$wdpa20_perc <- (marine_prov_sum$wdpa20_area/marine_prov_sum$prov_area)*100
marine_prov_sum$oecm24_perc <- (marine_prov_sum$oecm24_area/marine_prov_sum$prov_area)*100
marine_prov_sum$oecm22_perc <- (marine_prov_sum$oecm22_area/marine_prov_sum$prov_area)*100
marine_prov_sum$oecm20_perc <- (marine_prov_sum$oecm20_area/marine_prov_sum$prov_area)*100

## add PA + OECM coverage field
marine_prov_sum$pa_oecm_perc24 <- rowSums(marine_prov_sum[c("wdpa24_perc", "oecm24_perc")], na.rm = TRUE)
marine_prov_sum$pa_oecm_perc22 <- rowSums(marine_prov_sum[c("wdpa22_perc", "oecm22_perc")], na.rm = TRUE)
marine_prov_sum$pa_oecm_perc20 <- rowSums(marine_prov_sum[c("wdpa20_perc", "oecm20_perc")], na.rm = TRUE)

### count number of ecoregions >= 30% coverage
marine_prov_gte_30 <- marine_prov_sum %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
marine_prov_gte_30$OECM_addition_2024 <- marine_prov_gte_30$PA_OECM_2024 - marine_prov_gte_30$PA_2024
marine_prov_gte_30$OECM_addition_2022 <- marine_prov_gte_30$PA_OECM_2022 - marine_prov_gte_30$PA_2022
marine_prov_gte_30$OECM_addition_2020 <- marine_prov_gte_30$PA_OECM_2020 - marine_prov_gte_30$PA_2020

## calculate percentage
marine_prov_gte_30$PA_2024_perc <- (marine_prov_gte_30$PA_2024/62)*100
marine_prov_gte_30$PA_2022_perc <- (marine_prov_gte_30$PA_2022/62)*100
marine_prov_gte_30$PA_2020_perc <- (marine_prov_gte_30$PA_2020/62)*100
marine_prov_gte_30$OECM_addition_2024_perc <- (marine_prov_gte_30$OECM_addition_2024/62)*100
marine_prov_gte_30$OECM_addition_2022_perc <- (marine_prov_gte_30$OECM_addition_2022/62)*100
marine_prov_gte_30$OECM_addition_2020_perc <- (marine_prov_gte_30$OECM_addition_2020/62)*100

marine_prov_gte_30$biogeographical_unit <- "provinces"
marine_prov_gte_30$realm <- "marine"


############ pelagic provinces ###########################################################################################################
pelagic_prov <- read.csv("C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/ecoregions_marine/eco_marine_output_tables/MEOW_merge_table.csv")
## select pelagic provence 
pelagic_prov <- pelagic_prov %>%
  filter(TYPE == "PPOW")



### count number of provences >= 30% coverage
pelagic_prov_gte_30 <- pelagic_prov %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
pelagic_prov_gte_30$OECM_addition_2024 <- pelagic_prov_gte_30$PA_OECM_2024 - pelagic_prov_gte_30$PA_2024
pelagic_prov_gte_30$OECM_addition_2022 <- pelagic_prov_gte_30$PA_OECM_2022 - pelagic_prov_gte_30$PA_2022
pelagic_prov_gte_30$OECM_addition_2020 <- pelagic_prov_gte_30$PA_OECM_2020 - pelagic_prov_gte_30$PA_2020

## calculate percentage
pelagic_prov_gte_30$PA_2024_perc <- (pelagic_prov_gte_30$PA_2024/37)*100
pelagic_prov_gte_30$PA_2022_perc <- (pelagic_prov_gte_30$PA_2022/37)*100
pelagic_prov_gte_30$PA_2020_perc <- (pelagic_prov_gte_30$PA_2020/37)*100
pelagic_prov_gte_30$OECM_addition_2024_perc <- (pelagic_prov_gte_30$OECM_addition_2024/37)*100
pelagic_prov_gte_30$OECM_addition_2022_perc <- (pelagic_prov_gte_30$OECM_addition_2022/37)*100
pelagic_prov_gte_30$OECM_addition_2020_perc <- (pelagic_prov_gte_30$OECM_addition_2020/37)*100

pelagic_prov_gte_30$biogeographical_unit <- "provinces"
pelagic_prov_gte_30$realm <- "pelagic"


######### biomes ############################

#### terrestrial biomes
biomes <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_transform.csv")

## select terrestrial biomes 
terr_biomes <- biomes %>%
  filter(biome %in% c("T1","T2","T3","T4","T5","T6","T7"))

### count number of biomes >= 30% coverage
ter_biomes_gte_30 <- terr_biomes %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
ter_biomes_gte_30$OECM_addition_2024 <- ter_biomes_gte_30$PA_OECM_2024 - ter_biomes_gte_30$PA_2024
ter_biomes_gte_30$OECM_addition_2022 <- ter_biomes_gte_30$PA_OECM_2022 - ter_biomes_gte_30$PA_2022
ter_biomes_gte_30$OECM_addition_2020 <- ter_biomes_gte_30$PA_OECM_2020 - ter_biomes_gte_30$PA_2020

## calculate percentage
ter_biomes_gte_30$PA_2024_perc <- (ter_biomes_gte_30$PA_2024/7)*100
ter_biomes_gte_30$PA_2022_perc <- (ter_biomes_gte_30$PA_2022/7)*100
ter_biomes_gte_30$PA_2020_perc <- (ter_biomes_gte_30$PA_2020/7)*100
ter_biomes_gte_30$OECM_addition_2024_perc <- (ter_biomes_gte_30$OECM_addition_2024/7)*100
ter_biomes_gte_30$OECM_addition_2022_perc <- (ter_biomes_gte_30$OECM_addition_2022/7)*100
ter_biomes_gte_30$OECM_addition_2020_perc <- (ter_biomes_gte_30$OECM_addition_2020/7)*100

ter_biomes_gte_30$biogeographical_unit <- "biomes"
ter_biomes_gte_30$realm <- "terrestrial"


#### marine biomes
biomes <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_transform.csv")

## select marine biomes 
marine_biomes <- biomes %>%
  filter(biome %in% c("M1","M2","M3","M4"))

### count number of biomes >= 30% coverage
marine_biomes_gte_30 <- marine_biomes %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
marine_biomes_gte_30$OECM_addition_2024 <- marine_biomes_gte_30$PA_OECM_2024 - marine_biomes_gte_30$PA_2024
marine_biomes_gte_30$OECM_addition_2022 <- marine_biomes_gte_30$PA_OECM_2022 - marine_biomes_gte_30$PA_2022
marine_biomes_gte_30$OECM_addition_2020 <- marine_biomes_gte_30$PA_OECM_2020 - marine_biomes_gte_30$PA_2020

## calculate percentage
marine_biomes_gte_30$PA_2024_perc <- (marine_biomes_gte_30$PA_2024/4)*100
marine_biomes_gte_30$PA_2022_perc <- (marine_biomes_gte_30$PA_2022/4)*100
marine_biomes_gte_30$PA_2020_perc <- (marine_biomes_gte_30$PA_2020/4)*100
marine_biomes_gte_30$OECM_addition_2024_perc <- (marine_biomes_gte_30$OECM_addition_2024/4)*100
marine_biomes_gte_30$OECM_addition_2022_perc <- (marine_biomes_gte_30$OECM_addition_2022/4)*100
marine_biomes_gte_30$OECM_addition_2020_perc <- (marine_biomes_gte_30$OECM_addition_2020/4)*100

marine_biomes_gte_30$biogeographical_unit <- "biomes"
marine_biomes_gte_30$realm <- "marine"

#### transitional biomes
biomes <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_transform.csv")

## select trans biomes 
trans_biomes <- biomes %>%
  filter(biome %in% c("FM1","MFT1","MT1","MT2", "MT3", "SF1", "SF2", "SM1", "TF1"))

### count number of biomes >= 30% coverage
trans_biomes_gte_30 <- trans_biomes %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
trans_biomes_gte_30$OECM_addition_2024 <- trans_biomes_gte_30$PA_OECM_2024 - trans_biomes_gte_30$PA_2024
trans_biomes_gte_30$OECM_addition_2022 <- trans_biomes_gte_30$PA_OECM_2022 - trans_biomes_gte_30$PA_2022
trans_biomes_gte_30$OECM_addition_2020 <- trans_biomes_gte_30$PA_OECM_2020 - trans_biomes_gte_30$PA_2020

## calculate percentage
trans_biomes_gte_30$PA_2024_perc <- (trans_biomes_gte_30$PA_2024/9)*100
trans_biomes_gte_30$PA_2022_perc <- (trans_biomes_gte_30$PA_2022/9)*100
trans_biomes_gte_30$PA_2020_perc <- (trans_biomes_gte_30$PA_2020/9)*100
trans_biomes_gte_30$OECM_addition_2024_perc <- (trans_biomes_gte_30$OECM_addition_2024/9)*100
trans_biomes_gte_30$OECM_addition_2022_perc <- (trans_biomes_gte_30$OECM_addition_2022/9)*100
trans_biomes_gte_30$OECM_addition_2020_perc <- (trans_biomes_gte_30$OECM_addition_2020/9)*100

trans_biomes_gte_30$biogeographical_unit <- "biomes"
trans_biomes_gte_30$realm <- "transitional"


##################### freshwater biomes #################################################
biomes <- read.csv("O:/PP2024/chapter5_final/biome/biome_output_tables/biome_transform.csv")

## select fresh water biomes 
fresh_biomes <- biomes %>%
  filter(biome %in% c("F2","F3"))

### count number of biomes >= 30% coverage
fresh_biomes_gte_30 <- fresh_biomes %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_2022 = sum(wdpa22_perc >= 30, na.rm = TRUE),
    PA_2020 = sum(wdpa20_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE),
    PA_OECM_2022 = sum(pa_oecm_perc22 >= 30, na.rm = TRUE),
    PA_OECM_2020 = sum(pa_oecm_perc20 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
fresh_biomes_gte_30$OECM_addition_2024 <- fresh_biomes_gte_30$PA_OECM_2024 - fresh_biomes_gte_30$PA_2024
fresh_biomes_gte_30$OECM_addition_2022 <- fresh_biomes_gte_30$PA_OECM_2022 - fresh_biomes_gte_30$PA_2022
fresh_biomes_gte_30$OECM_addition_2020 <- fresh_biomes_gte_30$PA_OECM_2020 - fresh_biomes_gte_30$PA_2020

## calculate percentage
fresh_biomes_gte_30$PA_2024_perc <- (fresh_biomes_gte_30$PA_2024/3)*100
fresh_biomes_gte_30$PA_2022_perc <- (fresh_biomes_gte_30$PA_2022/3)*100
fresh_biomes_gte_30$PA_2020_perc <- (fresh_biomes_gte_30$PA_2020/3)*100
fresh_biomes_gte_30$OECM_addition_2024_perc <- (fresh_biomes_gte_30$OECM_addition_2024/3)*100
fresh_biomes_gte_30$OECM_addition_2022_perc <- (fresh_biomes_gte_30$OECM_addition_2022/3)*100
fresh_biomes_gte_30$OECM_addition_2020_perc <- (fresh_biomes_gte_30$OECM_addition_2020/3)*100

fresh_biomes_gte_30$biogeographical_unit <- "biomes"
fresh_biomes_gte_30$realm <- "freshwater"

###### rivers
rivers <- read.csv("O:/PP2024/chapter5_final/inland_waters/rivers_public.csv")

### count number of biomes >= 30% coverage
rivers_gte_30 <- rivers %>%
  summarise(
    PA_2024 = sum(wdpa24_perc >= 30, na.rm = TRUE),
    PA_OECM_2024 = sum(pa_oecm_perc24 >= 30, na.rm = TRUE)
  )

### calculate the difference between PA and PA+OECM
rivers_gte_30$OECM_addition_2024 <- rivers_gte_30$PA_OECM_2024 - rivers_gte_30$PA_2024

## calculate percentage
rivers_gte_30$PA_2024_perc <- (rivers_gte_30$PA_2024/10)*100
rivers_gte_30$OECM_addition_2024_perc <- (rivers_gte_30$OECM_addition_2024/10)*100

rivers_gte_30$biogeographical_unit <- "inland waters"
rivers_gte_30$realm <- "rivers and streams"
#### if river biome coverage is more than 30% then it will need adding to teh freshwater biome above but it is not in 2024

############# combining tables ######################################################

## subset tables to the columns we want 
eco_gte_30 <- subset(eco_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
marine_eco_gte_30 <- subset(marine_eco_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
fresh_eco_gte_30 <- subset(fresh_eco_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))

marine_prov_gte_30 <- subset(marine_prov_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
pelagic_prov_gte_30 <- subset(pelagic_prov_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
ter_biomes_gte_30 <- subset(ter_biomes_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
marine_biomes_gte_30 <- subset(marine_biomes_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
trans_biomes_gte_30 <- subset(trans_biomes_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))
fresh_biomes_gte_30 <- subset(fresh_biomes_gte_30, select = c(biogeographical_unit, realm,PA_2024, PA_2024_perc,PA_2022, PA_2022_perc, PA_2020,PA_2020_perc, OECM_addition_2024, OECM_addition_2024_perc, OECM_addition_2022, OECM_addition_2022_perc, OECM_addition_2020, OECM_addition_2020_perc))

#### combine tables
combined_df <- bind_rows(eco_gte_30, marine_eco_gte_30, fresh_eco_gte_30, ter_biomes_gte_30, marine_biomes_gte_30,fresh_biomes_gte_30, trans_biomes_gte_30, marine_prov_gte_30, pelagic_prov_gte_30)

names(combined_df)[names(combined_df) == "PA_2024"] <- "PA_2024_count"
names(combined_df)[names(combined_df) == "PA_2022"] <- "PA_2022_count"
names(combined_df)[names(combined_df) == "PA_2020"] <- "PA_2020_count"
names(combined_df)[names(combined_df) == "OECM_addition_2024"] <- "OECM_addition_2024"
names(combined_df)[names(combined_df) == "OECM_addition_2022"] <- "OECM_addition_2022"
names(combined_df)[names(combined_df) == "OECM_addition_2020"] <- "OECM_addition_2020"


write.csv(combined_df, "C:/Users/JoeG/OneDrive - WCMC/PP2024/chapter5_final/chapter5_biogeographic_regions.csv", row.names = FALSE)
