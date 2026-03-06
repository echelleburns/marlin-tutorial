## ::::::::::::::::::::::::::::::::::::::::::
## Script name: st_croix_map.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## Create orientation map for tutorial
## ::::::::::::::::::::::::::::::::::::::::::

# Load libraries
library(tidyverse)
library(rnaturalearth)
library(sf)

# Grab locations of interest
countries <- rnaturalearth::ne_countries()

# Define model region in latitude/longitude
model_region_4326 <- sf::st_bbox(c(xmin = -65.02, xmax = -64.4, 
                                   ymin = 17.58, ymax = 17.89), 
                                 crs = "epsg:4326") %>% 
  st_as_sfc() %>% 
  st_as_sf()

# Plot quickly
ggplot() + 
  geom_sf(data = countries, fill = "black", color = "white") + 
  geom_sf(data = model_region_4326, color = "red", size = 4) + 
  theme_void()

# Save the output
ggsave(here::here("figures", "small_area.png"), width = 6, height = 3, bg = NA)
