# Árvore de decisão

# Lendo o conjunto de dados
dataset = read.csv('Social_Network_Ads.csv')
dataset = dataset[3:5]

# Codificando o atributo alvo (classe) como um fator
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

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

# Árvore de decisão no conjunto de treinamento
# install.packages('rpart')
library(C50)
classifier = C5.0(x = training_set[1:2], 
                  y = training_set$Purchased)

# Prevendo os resultados do conjunto de teste
prob_pred = predict(classifier, newdata = test_set[-3], type = 'prob')
y_pred = predict(classifier, newdata = test_set[-3], type = 'class')

# Calculando a matriz de confusão
cm = table(test_set[, 3], y_pred)

# Visualizando os resultados no conjunto de treinamento
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.03)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.03)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set, type = 'class')
plot(set[, -3],
     main = 'Classificação via Árvore de Decisão (Treinamento)',
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
y_grid = predict(classifier, newdata = grid_set, type = 'class')
plot(set[, -3], main = 'Classificação via Árvore de Decisão (Teste)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Desenhando a árvore
plot(classifier)
text(classifier)
