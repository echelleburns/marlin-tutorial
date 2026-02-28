## ::::::::::::::::::::::::::::::::::::::::::
## Script name: setup.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## General setup script to source throughout 
## ::::::::::::::::::::::::::::::::::::::::::

# Define model region in wgs84
model_region_4326 <- sf::st_bbox(c(xmin = -65.02, xmax = -64.4, 
                                   ymin = 17.58, ymax = 17.89), 
                                 crs = "epsg:4326")

# Define desired CRS
crs <- "epsg:8118"

# Define model region in updated CRS
model_region <- sf::st_transform(model_region_4326, crs)

# Define resolution in meters (5x5 km)
resolution <- 5000

# Define raster
model_raster <- terra::rast(xmin = model_region[["xmin"]], 
                            xmax = model_region[["xmax"]], 
                            ymin = model_region[["ymin"]], 
                            ymax = model_region[["ymax"]], 
                            crs = crs, 
                            resolution = resolution)

model_raster_4326 <- terra::project(model_raster, "epsg:4326")
