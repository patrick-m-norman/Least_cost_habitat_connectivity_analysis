setwd('.')
#setwd('/media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/GER_least_cost_pathway_map/All_in_one_analysis/forests_above30_over1000ha')

library(sp)
library(dplyr)
library(tools)
library(rgdal)
library(magrittr)
library(dplyr)
library(sf)
library(purrr)
library(maptools)
library(rgeos)
library(tibble)


#loading shapefiles
file <- file_path_sans_ext(list.files(pattern = "\\cleaned_patch_polygons.shp$"))

all_polygons <- st_read('.', file) 
all_polygons.proj <- CRS("+proj=lcc +lat_0=0 +lon_0=134 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

all_points <- all_polygons %>% 
  st_sample(300000)
  
all_points2 <- all_points %>% 
  as(., 'Spatial') %>% 
  spTransform(., all_polygons.proj)

all_points2$long <- unlist(map(all_points2@coords[,1],1))
all_points2$latitude <- unlist(map(all_points2@coords[,2],1))

#Clipping out the points using polygons
file_polygons <- file_path_sans_ext(list.files(pattern = "media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/GER_least_cost_pathway_map/Polygons_of_regions/Polygons_around_major_corridors$"))
polygons_around_corridors <- readOGR(dsn= '/media/patrick/Patricks_HD/GER_and_Gondwanalink_report/GIS_layers/GER_least_cost_pathway_map/Polygons_of_regions', layer='Polygons_around_major_corridors2' )%>% 
  spTransform(., all_polygons.proj)

polygon_1 <- subset(polygons_around_corridors, polygons_around_corridors$id == 1, )
polygon_2 <- subset(polygons_around_corridors, polygons_around_corridors$id == 2, )
polygon_3 <- subset(polygons_around_corridors, polygons_around_corridors$id == 3, )
polygon_4 <- subset(polygons_around_corridors, polygons_around_corridors$id == 4, )
polygon_5 <- subset(polygons_around_corridors, polygons_around_corridors$id == 5, )
polygon_6 <- subset(polygons_around_corridors, polygons_around_corridors$id == 6, )
polygon_7 <- subset(polygons_around_corridors, polygons_around_corridors$id == 7, )
polygon_8 <- subset(polygons_around_corridors, polygons_around_corridors$id == 8, )
polygon_9 <- subset(polygons_around_corridors, polygons_around_corridors$id == 9, )
polygon_10 <- subset(polygons_around_corridors, polygons_around_corridors$id == 10, )
polygon_11 <- subset(polygons_around_corridors, polygons_around_corridors$id == 11, )

source1 <- all_points2[polygon_1, ]
source2 <- all_points2[polygon_2, ] 
source3 <- all_points2[polygon_3, ] 
source4 <- all_points2[polygon_4, ] 
source5 <- all_points2[polygon_5, ] 
source6 <- all_points2[polygon_6, ] 
source7 <- all_points2[polygon_7, ] 
source8 <- all_points2[polygon_8, ] 
source9 <- all_points2[polygon_9, ] 
source10 <- all_points2[polygon_10, ] 
source11 <- all_points2[polygon_11, ] 


destination1 <- gDifference(all_points2,polygon_1) %>%  as(.,"SpatialPointsDataFrame")
destination1@data = data.frame(ID=1:length(destination1))
destination2 <- gDifference(all_points2,polygon_2) %>%  as(.,"SpatialPointsDataFrame")
destination2@data = data.frame(ID=1:length(destination2))
destination3 <- gDifference(all_points2,polygon_3)%>%  as(.,"SpatialPointsDataFrame")
destination3@data = data.frame(ID=1:length(destination3))
destination4 <- gDifference(all_points2,polygon_4)%>%  as(.,"SpatialPointsDataFrame")
destination4@data = data.frame(ID=1:length(destination4))
destination5 <- gDifference(all_points2,polygon_5)%>%  as(.,"SpatialPointsDataFrame")
destination5@data = data.frame(ID=1:length(destination5))
destination6 <- gDifference(all_points2,polygon_6)%>%  as(.,"SpatialPointsDataFrame")
destination6@data = data.frame(ID=1:length(destination6))
destination7 <- gDifference(all_points2,polygon_7)%>%  as(.,"SpatialPointsDataFrame")
destination7@data = data.frame(ID=1:length(destination7))
destination8 <- gDifference(all_points2,polygon_8)%>%  as(.,"SpatialPointsDataFrame")
destination8@data = data.frame(ID=1:length(destination8))
destination9 <- gDifference(all_points2,polygon_9)%>%  as(.,"SpatialPointsDataFrame")
destination9@data = data.frame(ID=1:length(destination9))
destination10 <- gDifference(all_points2,polygon_10)%>%  as(.,"SpatialPointsDataFrame")
destination10@data = data.frame(ID=1:length(destination10))
destination11 <- gDifference(all_points2,polygon_11)%>%  as(.,"SpatialPointsDataFrame")
destination11@data = data.frame(ID=1:length(destination11))


# source1 <- all_points2[all_points2$latitude > -1929117,]
# source2 <- all_points2[all_points2$latitude > -2367715 & all_points2$latitude < -1929117, ]
# source3 <- all_points2[all_points2$latitude > -2798130 & all_points2$latitude < -2367715,]
# source4 <- all_points2[all_points2$latitude > -3041978 & all_points2$latitude < -2798130,]
# source5 <- all_points2[all_points2$latitude > -3764683 & all_points2$latitude < -3041978,]
# source6 <- all_points2[all_points2$latitude > -3972854 & all_points2$latitude < -3764683,]
# source7 <- all_points2[all_points2$latitude > -4346971 & all_points2$latitude < -3972854 & all_points2$long > 1193980,]
# source8 <- all_points2[all_points2$latitude > -4346971 & all_points2$latitude < -3972854 & all_points2$long < 1193980 & all_points2$long > 524299,]
# source9 <- all_points2[all_points2$latitude > -4787697 & all_points2$latitude < -4641389,]
# source10 <- all_points2[all_points2$latitude < -4787697,]


# #Destintation points
# destination8 <- all_points2[all_points2$latitude > -1929117,]
# destination1 <- all_points2[all_points2$latitude > -2367715 & all_points2$latitude < -1929117,]
# destination2 <- all_points2[all_points2$latitude > -2798130 & all_points2$latitude < -2367715,]
# destination3 <- all_points2[all_points2$latitude > -3041978 & all_points2$latitude < -2798130,]
# destination4 <- all_points2[all_points2$latitude > -3764683 & all_points2$latitude < -3041978,]
# destination5 <- all_points2[all_points2$latitude > -3972854 & all_points2$latitude < -3764683,]
# destination6 <- all_points2[all_points2$latitude > -4346971 & all_points2$latitude < -3972854 & all_points2$long > 1193980,]
# destination7 <- all_points2[all_points2$latitude > -4346971 & all_points2$latitude < -3972854 & all_points2$long < 1193980 & all_points2$long > 524299,]
# destination10 <- all_points2[all_points2$latitude < -4641389 & all_points2$latitude > -4787697,]
# destination9 <- all_points2[all_points2$latitude < -4787697,]

#Writing the randomised points
writeOGR(obj=source1, dsn='.', layer='source1', driver="ESRI Shapefile")
writeOGR(obj=source2, dsn='.', layer='source2', driver="ESRI Shapefile")
writeOGR(obj=source3, dsn='.', layer='source3', driver="ESRI Shapefile")
writeOGR(obj=source4, dsn='.', layer='source4', driver="ESRI Shapefile")
writeOGR(obj=source5, dsn='.', layer='source5', driver="ESRI Shapefile")
writeOGR(obj=source6, dsn='.', layer='source6', driver="ESRI Shapefile")
writeOGR(obj=source7, dsn='.', layer='source7', driver="ESRI Shapefile")
writeOGR(obj=source8, dsn='.', layer='source8', driver="ESRI Shapefile")
writeOGR(obj=source9, dsn='.', layer='source9', driver="ESRI Shapefile")
writeOGR(obj=source10, dsn='.', layer='source10', driver="ESRI Shapefile")
writeOGR(obj=source11, dsn='.', layer='source11', driver="ESRI Shapefile")
writeOGR(obj=destination1, dsn='.', layer='destination1', driver="ESRI Shapefile")
writeOGR(obj=destination2, dsn='.', layer='destination2', driver="ESRI Shapefile")
writeOGR(obj=destination3, dsn='.', layer='destination3', driver="ESRI Shapefile")
writeOGR(obj=destination4, dsn='.', layer='destination4', driver="ESRI Shapefile")
writeOGR(obj=destination5, dsn='.', layer='destination5', driver="ESRI Shapefile")
writeOGR(obj=destination6, dsn='.', layer='destination6', driver="ESRI Shapefile")
writeOGR(obj=destination7, dsn='.', layer='destination7', driver="ESRI Shapefile")
writeOGR(obj=destination8, dsn='.', layer='destination8', driver="ESRI Shapefile")
writeOGR(obj=destination9, dsn='.', layer='destination9', driver="ESRI Shapefile")
writeOGR(obj=destination10, dsn='.', layer='destination10', driver="ESRI Shapefile")
writeOGR(obj=destination11, dsn='.', layer='destination11', driver="ESRI Shapefile")
