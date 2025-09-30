# Install geodata terra, and load libraries
install.packages("geodata",dependencies=TRUE,repos="https://cloud.r-project.org")
library(geodata)
library(terra)

# Read the contents of the csv file into a dataset
ouzelData <- read.table('data/Data_SwissBreedingBirds.csv', header = T, sep = ',')
