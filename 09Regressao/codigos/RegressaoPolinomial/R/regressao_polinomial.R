# Regressão Polinomial

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

# Regressão linear no conjunto de dados
lin_reg = lm(formula = Salary ~ .,
             data = dataset)

# Regressão polinimial no conjunto de dados
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula = Salary ~ .,
              data = dataset)

# Visualizando a regressão linear no conjunto de treinamento
# install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Verdade ou Blefe (Linear)') +
  xlab('Nível') +
  ylab('Salário')

# Visualizando os resultados da Regressão polinomial
# install.packages('ggplot2')
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Verdade ou Blefe (Polinomial)') +
  xlab('Nível') +
  ylab('Salário')

# Visualizando os resultados do modelo
# (alta resolução e curva mais suave)
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(poly_reg,
                                        newdata = data.frame(Level = x_grid,
                                                             Level2 = x_grid^2,
                                                             Level3 = x_grid^3,
                                                             Level4 = x_grid^4))),
            colour = 'blue') +
  ggtitle('Verdade ou Blefe (Polinomial)') +
  xlab('Nível') +
  ylab('Salário')

# Prevendo um novo resultado com a regressão linear
predict(lin_reg, data.frame(Level = 6.5))

# Prevendo um novo resultado com a regressão polinomial
predict(poly_reg, data.frame(Level = 6.5,
                             Level2 = 6.5^2,
                             Level3 = 6.5^3,
                             Level4 = 6.5^4))
