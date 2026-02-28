## ::::::::::::::::::::::::::::::::::::::::::
## Script name: subset_land_area.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## Just save a simpler version of the land area for 
## plotting later
## ::::::::::::::::::::::::::::::::::::::::::

# Load libraries
library(sf)
library(tidyverse)

# Source files
source(here::here("src", "setup.R"))

# Load data 
land <- st_read(here::here("data", "raw", "N15W065", "N15W065.shp")) %>% 
  st_transform(., crs)

# Crop to model area
land_small <- land %>% 
  st_crop(., model_region) %>% 
  st_union() %>% 
  st_polygonize() %>%
  st_as_sf()

# Save area 
st_write(land_small, here::here("data", "processed", "st_croix_land.gpkg"), append = FALSE)
