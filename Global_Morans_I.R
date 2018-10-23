#Moran's I Test
#Again use the PopDen vector
mi <- moran.test(PopDen, crd.lw, zero.policy = TRUE)
mi
mi2 <- moran.test(OccDen, crd.lw, zero.policy = TRUE)
mi2
mi3 <- moran.test(VacDen, crd.lw, zero.policy = TRUE)
mi3

#To contextualize your Moran's I value, retrieve range of potential Moran's I values.
moran.range <- function(lw) {
  wmat <- listw2mat(lw)
  return(range(eigen((wmat + t(wmat))/2)$values))
}
moran.range(crd.lw)

#Perform the Z-test
#You can get the necessary values from your mi object resulting from your Moran's I test above.
#For example, the Moran's I value is the first value in the output mi, so you call mi$estimate[1] to get the value.
mi$estimate[1]
mi2$estimate[1]
mi3$estimate[1]
z.i=mi2$estimate[1]-mi2$estimate[2]/(mi2$estimate[3])
z.i
z.i=mi3$estimate[1]-mi3$estimate[2]/(mi3$estimate[3])
z.i
