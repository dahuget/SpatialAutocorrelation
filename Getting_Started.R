### GEOG 418/518 ###
### LAB 3 - SPATIAL AUTOCORRELATION ###
library(plyr)
library(dplyr)
library(spdep)
library(GISTools)
library(raster)
library(maptools)

#Get the AGGREGATE DISSEMINATION AREA shapefile here:
#http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm

#Get the AGGREGATE DISSEMINATION AREA population and dwelling count 2016 data here: 
#http://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/comprehensive.cfm

#Call the disseination area shapefile
dissem <- shapefile("lada000b16a_e.shp")
#select dissemination areas in the Capital and Cowichan Valley regions
dissem.sub <- dissem[dissem$CDNAME %in% c("Capital", "Cowichan Valley"),]

#Call the census population data
census.16 <- read.csv("T1701EN.csv", check.names = FALSE)

#fix the column names
#remove punctuation and spaces and replace with "_"
#names(census.16) <- gsub("%", "Percent", names(census.16))
names(census.16) <- gsub("[[:space:]]|[[:punct:]]", "_", names(census.16), fixed = FALSE)
names(census.16) <- gsub("__", "_", names(census.16), fixed = TRUE)
names(census.16) <- gsub("__", "_", names(census.16), fixed = TRUE)
census.16 <- census.16[,-12]

#remove columns with "french"
census.16 <- census.16[,-grep("french", names(census.16))]

#select columns we want by name
census.16 <- census.16[,names(census.16) %in% c("Geographic_code", "Population_2016", "Land_area_in_square_kilometres_2016", "Total_private_dwellings_2016",
                                                "Private_dwellings_occupied_by_usual_residents_2016", "Population_density_per_square_kilometre_2016")]

#occupied dwelling density
census.16$Private_dwelling_occupied_density_per_square_kilometre_2016 <- census.16$Private_dwellings_occupied_by_usual_residents_2016/census.16$Land_area_in_square_kilometres_2016

#generalization of private dwelling vacancies
census.16$Private_dwelling_vacancies_2016 <- census.16$Total_private_dwellings_2016 - census.16$Private_dwellings_occupied_by_usual_residents_2016

#generalization of private dwelling vacancy density
census.16$Private_dwelling_vacancy_density_per_square_kilometre_2016 <- census.16$Private_dwelling_vacancies_2016/census.16$Land_area_in_square_kilometres_2016

#rename "Geographic_code" as "ADAUID" to match the dissemination shapefile
names(census.16)[1] <- "ADAUID"

#now merge with the shapefile based on dissemination ID
crd.data <- merge(dissem.sub, census.16, by = "ADAUID")
#remove NA
crd.data <- crd.data[!is.na(crd.data$Population_2016),]
#crd.data is our working dataset, class SpatialPolygonsDataFrame and it now includes the census data as attributes
class(crd.data)
summary(crd.data)

#Create a choloropleth map of Population density per km2 in 2016
#vectors of population densities & private dwelling vacancies 
PopDen <- crd.data$Population_density_per_square_kilometre_2016
OccDen <- crd.data$Private_dwelling_occupied_density_per_square_kilometre_2016
VacDen <- crd.data$Private_dwelling_vacancy_density_per_square_kilometre_2016
#create a list of 6 colours
shades <- auto.shading(PopDen, n=6, cols = brewer.pal(6, 'Oranges'))
shades.vacancy <- auto.shading(VacDen, n=6, cols = brewer.pal(6, 'Blues'))
shades.occupied <- auto.shading(OccDen, n=6, cols = brewer.pal(6, 'Purples'))
#map the data with associated colours
choropleth(crd.data, PopDen, shades, main = "Population Density for Capital and Cowichan Regional Districts")
choropleth(crd.data, VacDen, shades.vacancy, main = "Vacancy Density for Capital and Cowichan Regional Districts")
choropleth(crd.data, OccDen, shades.occupied, main = "Occupied Density for Capital and Cowichan Regional Districts")
#title(title.text)
#add a legend
legend_coor <- locator(1)
legend_coor
legend.text = expression(paste("Population Density per km"^"2"," in 2016"))
legend.vacancy.text = expression(paste("Vacancy Density per km"^"2"," in 2016"))
legend.occupied.text = expression(paste("Occupied Density per km"^"2"," in 2016"))
choro.legend(3837035, 1959193, shades, title = legend.text, cex = 0.5)
choro.legend(3653863, 2047977, shades.vacancy, title = legend.vacancy.text, cex = 0.45)
choro.legend(3653863, 2047977, shades.occupied, title = legend.occupied.text, cex = 0.45)

