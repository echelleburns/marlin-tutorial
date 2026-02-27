## ::::::::::::::::::::::::::::::::::::::::::
## Script name: create_habitat_map.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## Create a habitat map for the species of interest
## ::::::::::::::::::::::::::::::::::::::::::
## Notes:
## I am using the Allan Coral Atlas database to get reef
## values for St. Croix in the US Virgin Islands. This
## will be my proxy for a habitat map for this tutorial.
## https://allencoralatlas.org/
## ::::::::::::::::::::::::::::::::::::::::::

# Load relevant libraries
library(sf)
library(tidyverse)
library(terra)

# Source files
source(here::here("src", "setup.R"))

# Load data 
reef_data <- st_read(here::here("data", "raw", "Virgin-Islander-Exclusive-Economic-Zone-20230309221253", "Reef-Extent", "reefextent.gpkg"))

# Subset to study region
reef_data_subset <- reef_data %>% 
  st_crop(., model_region_4326) %>%
  mutate(reef = 1) %>% 
  st_transform(., crs)

# Convert to a raster
reef_raster <- terra::rasterize(terra::vect(reef_data_subset), model_raster, field = "reef")

# Calculate distance to reef, we can use this as our habitat layer
distance_reef <- terra::distance(reef_raster)

# Remove values that are land - these should be NAs
## Do this by grabbing land areas - we'll use the GEBCO bathymetry data to do this
ocean_raster <- oceandatr::get_bathymetry(spatial_grid = model_region_4326 %>% 
                                            st_as_sfc() %>% 
                                            st_as_sf() %>% st_buffer(., 10),  
                                          raw = TRUE, classify_bathymetry = FALSE) %>% 
  terra::project(., model_raster)
ocean_raster[ocean_raster > 0] <- NA
ocean_raster[!is.na(ocean_raster)] <- 1

distance_reef <- distance_reef*ocean_raster

# Use the inverse as habitat suitability and standardize between 0 and 1
habitat_map <- abs((distance_reef/max(values(distance_reef), na.rm = T))-1)

# Save the output as a csv file 
habitat_map_df <- terra::as.data.frame(habitat_map, xy = TRUE, na.rm = FALSE) %>% 
  rename(habitat_suitability = reef)

write_csv(habitat_map_df, here::here("data", "processed", "habitat_suitability.csv"))
