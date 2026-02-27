## ::::::::::::::::::::::::::::::::::::::::::
## Script name: create_selectivity_curve.R
## Author: Echelle Burns, emLab, UC Santa Barbara
## Date: 2026-02-25
## Purpose:
## Create selectivity curve for the species of interest
## ::::::::::::::::::::::::::::::::::::::::::
## Notes:
## I am using the most recent stock assessment for the
## stoplight parrotfish in St. Croix, and am using the
## selectivity curves in figure 8: 
## https://caribbeanfmc.com/images/General%20Archive/SSC/2025-sep/SEDAR%2084%20US%20Caribbean%20Yellowtail%20Snapper%20STX%20Final%20Stock%20Assessment%20Report%20-%20August%202025%20(1).pdf
## I use ImageJ to grab the values from the plot and I 
## copy/paste them into this script.
## In ImageJ, you open the file, then select the rectangle
## that is the plot area. Then go to Plugins > Figure Calibration
## Here, you can set your x and y bounds. 
## Now, you can select the multipoint tool on ImageJ
## and click along the lines you want to save coordinates of.
## Once all your points are selected you can use 
## Analyze > Measure to get a pop up of the x/y coordinates.
## If you select this screen, you should be able to save as
## a csv and output locally. 
## ::::::::::::::::::::::::::::::::::::::::::

# Load libraries 
library(tidyverse)

# Load data
selectivity_curve <- read.csv(here::here("data", "processed", "selectivity_curve.csv"))

# Quick plot to check 
ggplot()  + 
  geom_line(data = selectivity_curve, mapping = aes(x = X, y = Y)) + 
  labs(x = "Length (cm)", y = "Proportion")
