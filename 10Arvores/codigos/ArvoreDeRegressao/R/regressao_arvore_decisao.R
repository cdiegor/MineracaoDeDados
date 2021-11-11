# Regressão via Árvore de Decisão

# Lendo o conjunto de dados
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Dividindo o conjunto de dados em treinamento e teste
# # install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Salary, SplitRatio = 2/3)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Escala de atributos
# training_set = scale(training_set)
# test_set = scale(test_set)

# Regressão via árvore de decisão 
# install.packages('rpart')
library(rpart)
regressor = rpart(formula = Salary ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 1))

# Prevendo um novo resultado de teste
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualizando os resultados da árvore de regressão
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Verdade ou blefe (Regressão via árvore de decisão)') +
  xlab('Level') +
  ylab('Salary')

# Visualizando a árvore
plot(regressor)
text(regressor)
