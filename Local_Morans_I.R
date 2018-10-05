#Local Moran's I
lisa.test <- localmoran(PopDen, crd.lw)
lisa.test
#Create a choropleth map of the LISA values.
lisa.shades <- auto.shading(c(lisa.test[,1],-lisa.test[,1]),cols=brewer.pal(5,"PRGn"))
choropleth(crd.data, lisa.test[,1],shading=lisa.shades)
choro.legend(3860000, 1965000,lisa.shades,fmt="%6.2f")

#Create a Moran's I scatterplot
moran.plot(PopDen, crd.lw, zero.policy=NULL, spChk=NULL, labels=NULL, xlab="Population Density", 
           ylab="Spatially Lagged Population Density", quiet=NULL)

