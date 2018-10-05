#Moran's I Test
#Again use the PopDen vector
mi <- moran.test(PopDen, crd.lw, zero.policy = TRUE)
mi

#To contextualize your Moran's I value, retrieve range of potential Moran's I values.
moran.range <- function(lw) {
  wmat <- listw2mat(lw)
  return(range(eigen((wmat + t(wmat))/2)$values))
}
moran.range(crd.lw)

#Perform the Z-test
#You can get the necessary values from your mi object resulting from your Moran's I test above.
#For example, the Moran's I value is the first value in the output mi, so you call mi$estimate[1] to get the value.
