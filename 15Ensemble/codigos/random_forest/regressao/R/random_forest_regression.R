# Regressão Random Forest

# Lendo o conjunto de dados
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Aplicando a regressão Random Forest no conjunto de dados
# install.packages('randomForest')
library(randomForest)
set.seed(0)
regressor = randomForest(x = dataset[-2],
                         y = dataset$Salary,
                         ntree = 5)

# Prevendo um novo resultado com a regressão Random Forest
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualizando os resultados da regressão Random Forest
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Random Forest Regression)') +
  xlab('Level') +
  ylab('Salary')