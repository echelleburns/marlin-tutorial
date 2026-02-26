## ::::::::::::::::::::::::::::::::::::::::::
## Script name: setup.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## General setup script to source throughout 
## ::::::::::::::::::::::::::::::::::::::::::

# Define model region
model_region <- sf::st_bbox(c(xmin = -65.02, xmax = -64.4, 
                              ymin = 17.58, ymax = 17.89))

# Define resolution in decimal degrees
resolution <- 0.01

# Define raster
model_raster <- terra::rast(xmin = model_region[["xmin"]], 
                            xmax = model_region[["xmax"]], 
                            ymin = model_region[["ymin"]], 
                            ymax = model_region[["ymax"]], 
                            crs = "epsg:4326", 
                            resolution = resolution)
