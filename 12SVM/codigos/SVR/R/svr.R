# SVR

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

# SVR no conjunto de dados
# install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ .,
                data = dataset,
                type = 'eps-regression',
                kernel = 'radial')

# Prevendo um novo resultado
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualizando os resultados do SVR
# install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Verdade ou Blefe (SVR)') +
  xlab('Level') +
  ylab('Salary')

# Visualizando os resultados SVR (maior resolução e curva suave)
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Verdade ou Blefe (SVR)') +
  xlab('Level') +
  ylab('Salary')