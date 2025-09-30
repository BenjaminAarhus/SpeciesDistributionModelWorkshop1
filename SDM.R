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


