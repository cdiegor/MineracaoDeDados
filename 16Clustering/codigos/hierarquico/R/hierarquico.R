# Agrupamento hierarquico

# Lendo o conjunto de dados
dataset = read.csv('Mall_Customers.csv')
dataset = dataset[4:5]

# Agrupamento hierárquico
hier = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')

# Usando o dendrograma para encontrar o número ótimo de grupos
dendrogram = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')
plot(dendrogram,
     main = paste('Dendrograma'),
     xlab = 'Clientes',
     ylab = 'Distâncias euclidianas')

# Cortando a árvore para o número de grupos
y_hier = cutree(hier, 5)

# Visualizando os grupos
library(cluster)
clusplot(dataset,
         y_hier,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels= 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Grupos de clientes'),
         xlab = 'Renda',
         ylab = 'Score')