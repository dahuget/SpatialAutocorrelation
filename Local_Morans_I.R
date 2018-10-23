#Local Moran's I
lisa.test <- localmoran(PopDen, crd.lw)
lisa.test
lisa.occupied.test <- localmoran(OccDen, crd.lw)
lisa.occupied.test
summary(lisa.occupied.test)
lisa.vacancy.test <- localmoran(VacDen, crd.lw)
lisa.vacancy.test
summary(lisa.vacancy.test)
#Create a choropleth map of the LISA values.
lisa.shades <- auto.shading(c(lisa.test[,1],-lisa.test[,1]),cols=brewer.pal(5,"PRGn"))
choropleth(crd.data, lisa.test[,1],shading=lisa.shades, main="Local Moran's I for Population Density")
lisa.occupied.shades <- auto.shading(c(lisa.occupied.test[,1],-lisa.occupied.test[,1]),cols=brewer.pal(5,"PRGn"))
choropleth(crd.data, lisa.test[,1],shading=lisa.occupied.shades, main="Local Moran's I for Occupied Dwelling Density")
lisa.vacancy.shades <- auto.shading(c(lisa.vacancy.test[,1],-lisa.vacancy.test[,1]),cols=brewer.pal(5,"PRGn"))
choropleth(crd.data, lisa.test[,1],shading=lisa.vacancy.shades, main="Local Moran's I for Vacancy Dwelling Density")
#legend2.text = expression(paste("LISA ValuesPopulation Density per km"^"2"," in 2016"))
choro.legend(3663863, 2047977,lisa.shades,fmt="%6.2f", cex=0.45, title="LISA Values")
choro.legend(3653863, 2047977,lisa.occupied.shades,fmt="%6.2f", cex=0.45, title="LISA Values")
choro.legend(3653863, 2047977,lisa.vacancy.shades,fmt="%6.2f", cex=0.45, title="LISA Values")

#Create a Moran's I scatterplot
moran.plot(main="Moran's I",PopDen, crd.lw, zero.policy=NULL, spChk=NULL, labels=NULL, xlab="Population Density", 
           ylab="Spatially Lagged Population Density", quiet=NULL)
moran.plot(main="Moran's I",OccDen, crd.lw, zero.policy=NULL, spChk=NULL, labels=NULL, xlab="Occupied Density", 
           ylab="Spatially Lagged Occupied Density", quiet=NULL)
moran.plot(main="Moran's I",VacDen, crd.lw, zero.policy=NULL, spChk=NULL, labels=NULL, xlab="Vacancy Density", 
           ylab="Spatially Lagged Vacancy Density", quiet=NULL)

#Get P-values from last column of LISA table
p.lisa.occupied=lisa.occupied.test[,5]
p.lisa.occupied.shades <- auto.shading(c(lisa.occupied.test[,5],-lisa.occupied.test[,5]),cols=brewer.pal(5,"PRGn"))
p.lisa.vacancy=lisa.vacancy.test[,5]
p.lisa.vacancy.shades <- auto.shading(c(lisa.vacancy.test[,5],-lisa.vacancy.test[,5]),cols=brewer.pal(5,"PRGn"))
#Create a choropleth map of the LISA P-values.
choropleth(crd.data,p.lisa.occupied,shading = p.lisa.occupied.shades, main = "Occupied Dwelling LISA P-values")
choro.legend(3786037, 2047977,lisa.occupied.shades,fmt="%6.2f", cex=0.45)
choropleth(crd.data,p.lisa.vacancy,shading = p.lisa.vacancy.shades, main = "Vacancy Dwelling LISA P-values")
choro.legend(3786037, 2047977,lisa.vacancy.shades,fmt="%6.2f", cex=0.45)


