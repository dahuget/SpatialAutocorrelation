###Create Spatial Neighbourhood Weights Matrix ###
#queen's neighbour
crd.nb <- poly2nb(crd.data)

plot(crd.data)
plot(crd.nb, coordinates(crd.data), add = TRUE, col = "red")

#rooks neighbour
crd.nb2 <- poly2nb(crd.data, queen = FALSE)
#Now, create a new map that overlays the rook neighbors file (in yellow) onto the queen neighbors file (in red).
plot(crd.data, border = "lightgrey")
plot(crd.nb, coordinates(crd.data), add = TRUE, col = "red")
plot(crd.nb2, coordinates(crd.data), add = TRUE, col = "yellow", lwd = 2, lty = "dashed")

#Create the spatial weights neighbour list using the queen's case
crd.lw <- nb2listw(crd.nb, zero.policy = TRUE, style = "W")
print.listw(crd.lw, zero.policy = TRUE)

###Create lagged Means Map###
#Look at population density per km2
#lagged means
PopDen.lagged.means = lag.listw(crd.lw, PopDen, zero.policy = TRUE)
OccDen.lagged.means = lag.listw(crd.lw, OccDen, zero.policy = TRUE)
VacDen.lagged.means = lag.listw(crd.lw, VacDen, zero.policy = TRUE)
#Map the lagged means using a new shading object called shades2
shades2 <- auto.shading(PopDen.lagged.means, n=6, cols = brewer.pal(6, 'Oranges'))
shades2.occupied <- auto.shading(OccDen.lagged.means, n=6, cols = brewer.pal(6, 'Purples'))
shades2.vacancy <- auto.shading(VacDen.lagged.means, n=6, cols = brewer.pal(6, 'Blues'))
choropleth(crd.data, PopDen.lagged.means,shades2, main = "Lagged Means Population Density for Capital and Cowichan Regional Districts")
choropleth(crd.data, OccDen.lagged.means,shades2.occupied, main = "Lagged Means Occupied Density for Capital and Cowichan Regional Districts")
choropleth(crd.data, VacDen.lagged.means,shades2.vacancy, main = "Lagged Means Vacancy Density for Capital and Cowichan Regional Districts")
#legend_coor <- locator(1)
choro.legend(3837035, 1959193, shades2, title = legend.text, cex = 0.5)
choro.legend(3653863, 2047977, shades2.occupied, title = legend.occupied.text, cex = 0.45)
choro.legend(3653863, 2047977, shades2.vacancy, title = legend.vacancy.text, cex = 0.45)
#choro.legend(3864000, 1965000, shades2)