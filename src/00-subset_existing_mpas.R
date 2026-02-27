## ::::::::::::::::::::::::::::::::::::::::::
## Script name: subset_existing_mpas.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## Subset mpatlas to the region of interest
## ::::::::::::::::::::::::::::::::::::::::::
## Notes:
## I am using a layer from the MPAtlas that was
## previously downloaded by emLab. You can grab
## an updated version from the website.
## URL: https://mpatlas.org/
## ::::::::::::::::::::::::::::::::::::::::::

# Load relevant libraries
library(sf)
library(tidyverse)

# Source files
source(here::here("src", "setup.R"))

# Load data
mpas <- st_read(here::here("data", "raw", "mpatlas_20201223_clean"))

# Switch it to TRUE for this piece
sf::sf_use_s2(TRUE)

# Subset to area of interest
area_mpas <- mpas %>% 
  filter(no_take == "All" & implemente == 1) %>%
  st_make_valid() %>% 
  st_crop(., model_region_4326) %>% 
  st_union()

# Save output 
st_write(area_mpas, here::here("data", "processed", "existing_mpas.gpkg"), append = TRUE)

# Switch back to FALSE
sf::sf_use_s2(FALSE)
