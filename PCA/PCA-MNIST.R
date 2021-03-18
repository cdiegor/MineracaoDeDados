
output_img <- function (photo, name)
{
  out_photo <- photo/max(photo)
  dim(out_photo) <- c(28,28)
  out_photo <- t(out_photo)
  writePNG(out_photo, name)
}

MNIST <- read.csv("mnist_test.csv")
photo <- t(data.matrix(MNIST[2,2:ncol(MNIST)]))
output_img(photo, "pca_original.png")
dim(photo) <- c(28,28)
photo.pca <- prcomp(photo, center = F)
PCs <- c(round(0.1 * nrow(photo)), round(0.2 * nrow(photo)),
         round(0.3 * nrow(photo)), round(0.4 * nrow(photo)),
         round(0.5 * nrow(photo)), round(0.6 * nrow(photo)),
         round(0.7 * nrow(photo)), round(0.8 * nrow(photo)), 
         round(0.9 * nrow(photo)))
for (i in PCs)
{
  pca.img <- photo.pca$x[,1:i] %*% t(photo.pca$rotation[,1:i])
  output_img(pca.img, paste("pca_" , i, ".png"))
}
