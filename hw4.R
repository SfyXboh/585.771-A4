library(dplyr)
library(tidyr)
library(tibble)
library(magrittr)
library(ggplot2)

# import data
annualDosage <- read.csv("county_annual.csv"); annualDosage <- as_tibble(annualDosage);
county_pop <- read.csv("county_pop_arcos.csv"); county_pop <- as_tibble(county_pop);
land <- read.csv("land_area.csv"); land <- as_tibble(land)

# select land area from 2010
land_area <- 
  land %>% 
  select(Areaname, STCOU, LND110210D)

# fill in fips code for Montgomery, AR
annualDosage %<>% 
  mutate(countyfips = case_when(BUYER_STATE == "AR" & 
                                BUYER_COUNTY == "MONTGOMERY" ~ 05097,
                                TRUE ~ countyfips))

# remove American terrirories with no fips code
annualDosage %<>% 
  filter(!is.na(countyfips))

# join population with land area
land_area %<>%
  rename(countyfips = STCOU) # match column name
county_info <- 
  left_join(x = county_pop, y = land_area, by = "countyfips")

# join county info with drug data
annualDosage %<>%
  mutate(countyfips = as.factor(countyfips),
         year = as.factor(year))
county_info %<>%
  mutate(countyfips = as.factor(countyfips),
         year = as.factor(year))
Annual <- 
  left_join(annualDosage, county_info, by = c("BUYER_COUNTY",
                                              "BUYER_STATE",
                                              "year",
                                              "countyfips"))

# remove NA
Annual %<>% 
  filter(!is.na(STATE))

# add column pills in millions
Annual %<>% 
  mutate(Pills_in_millions = DOSAGE_UNIT/1000000)

# plot mean pills per county per year
raw_average <- 
  Annual %>%
  ggplot(aes(x = year, y = Pills_in_millions, group = 1)) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  labs(title = "Average Number of Opioid Pills Shipped to a US County",
       y = "Number of pills in millions") +
  theme_minimal()

raw_average

# save the data to be loaded in python
data <- as.data.frame(Annual)
saveRDS(data, "data.rds")
