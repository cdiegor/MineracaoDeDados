# Agrupamento K-Medianas

# Lendo o conjunto de dados
dataset = read.csv('Mall_Customers.csv')
dataset = dataset[4:5]

# K-Means
set.seed(0)
kmeans = kmeans(x = dataset, centers = 5)
y_kmeans = kmeans$cluster

# Usando o método do cotovelo para encontrar o número de grupos
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(dataset, i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('Método do cotovelo'),
     xlab = 'Número de grupos',
     ylab = 'WCSS')


# Visualising the clusters
library(cluster)
clusplot(dataset,
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Grupos de clientes'),
         xlab = 'Renda',
         ylab = 'Score')