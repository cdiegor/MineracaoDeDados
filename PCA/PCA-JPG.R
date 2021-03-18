library(jpeg)
name <- "cape-town"
photo <- readJPEG(paste(name, ".jpg", sep=""))
photo <- photo[,,1]
####### introducing PCA method #######
photo.pca <- prcomp(photo, center = F)
####### Image compression with different values of PCs #######
PCs <- c(round(0.01 * nrow(photo)), round(0.02 * nrow(photo)),
         round(0.03 * nrow(photo)), round(0.04 * nrow(photo)),
         round(0.05 * nrow(photo)), round(0.10 * nrow(photo)),
         round(0.15 * nrow(photo)), round(0.20 * nrow(photo)),
         round(0.25 * nrow(photo)), round(0.30 * nrow(photo)),
         round(0.35 * nrow(photo)), round(0.40 * nrow(photo)), 
         round(0.50 * nrow(photo)), round(0.60 * nrow(photo)), 
         round(0.70 * nrow(photo)), round(0.80 * nrow(photo)),
         round(0.90 * nrow(photo)), round(1.00 * nrow(photo)) )
for (i in PCs)
{
  pca.img <- photo.pca$x[,1:i] %*% t(photo.pca$rotation[,1:i])
  writeJPEG(pca.img, paste(name, "_" , i, ".jpg", sep = ""))
}
