# Regressão Linear Simples

# Lendo o conjunto de dados
dataset = read.csv('Salary_Data.csv')

# Dividindo o conjunto de dados em treinamento e teste
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Escala de atributos
# training_set = scale(training_set)
# test_set = scale(test_set)

# Regressão linear simples no conjunto de treinamento
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

# Prevendo os resultados no conjunto de teste
y_pred = predict(regressor, newdata = test_set)

# Visualizando os resultados no conjunto de treinamento
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salário x Experiência (Treinamento)') +
  xlab('Anos de experiência') +
  ylab('Salário')

# Visualizando os resultados no conjunto de teste
library(ggplot2)
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salário x Experiência (Teste)') +
  xlab('Anos de experiência') +
  ylab('Salário')
