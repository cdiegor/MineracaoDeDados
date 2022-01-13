# Classificação Adaboost

# Lendo o conjunto de dados
dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]

# Modificando a classe para {-1,1}
dataset$Purchased = 2 * dataset$Purchased - 1

# Dividindo o conjunto de dados em treinamento e teste
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Escala de atributos
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

# Classificação Random Forest Classification no conjunto de treinamento
# install.packages('JOUSBoost')
library(JOUSBoost)
set.seed(0)
classifier = adaboost(as.matrix(training_set[1:2]), training_set$Purchased, tree_depth = 2,
                      n_rounds = 10, verbose = TRUE)

# Prevendo os resultados no conjunto de teste
y_pred = predict(classifier, X = test_set[1:2])

# Calculando a matriz de confusão
cm = table(test_set[, 3], y_pred)

# Visualizando os resultados no conjunto de treinamento
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.03)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.03)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, grid_set)
plot(set[, -3],
     main = 'Classificação Adaboost (Treinamento)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Visualizando os resultados no conjunto de teste
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.03)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.03)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, grid_set)
plot(set[, -3], main = 'Classificação Adaboost (Teste)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

