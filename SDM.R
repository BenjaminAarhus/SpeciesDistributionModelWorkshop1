# Install geodata terra, and load libraries
install.packages("geodata",dependencies=TRUE,repos="https://cloud.r-project.org")
library(geodata)
library(terra)

# Read the contents of the csv file into a data set
ouzelData <- read.table('data/Data_SwissBreedingBirds.csv', header = T, sep = ',')

# Subset the data to remove excess data and leave only the relevant columns
ouzelColumns <- c('Turdus_torquatus', 'bio_5', 'bio_2', 'bio_14', 'blockCV_tile')
ouzelDateFrame <-data.frame(ouzelData)[ouzelColumns]
# Output result
summary(ouzelDateFrame)

# Create Output Directory
resultsDir <- "C:/Users/Ben/Documents/SpeciesDistributionModelWorkshop1/Results"

# Create maps of current and future climate shaped to Switzerland
currentClimate <- worldclim_country("Switzerland", version = "2.1", var = 'bio', res = 10, lon = 5.5, lat = 45.5, path = resultsDir)[[c(2,5,14)]]
futureClimate <- cmip6_world(var = "bio", model = "CNRM-CM6-1-HR", ssp = "245", res = 10, time = "2041-2060", lon = c(5.96, 10.49), lat = c(45.82, 47.81), path = resultsDir)[[c(2,5,14)]]


# A spatial mask of Switzerland in Swiss coordinates
bg <- rast('/vsicurl/https://damariszurell.github.io/SDM-Intro/CH_mask.tif')

currentClimate <- terra::project(currentClimate, bg)
futureClimate <- terra::project(futureClimate, bg)
# We need to change the projection of our climate data to match that of the bg file.

currentClimate <- terra::resample(currentClimate, bg)
futureClimate <- terra::resample(futureClimate, bg)
#we then need to make the resolution equivalent to bg. 


currentClimate <- terra::mask(currentClimate, bg)
futureClimate <- terra::mask(futureClimate, bg)
#we then need to clip the extent to match an outline of Switzerland

names(currentClimate) <- c('bio_2', 'bio_5', 'bio_14')
names(futureClimate) <- c('bio_2', 'bio_5', 'bio_14')

# Plot both the current and future climates
plot(currentClimate)
plot(futureClimate)
