# Modelo de pre-processamento

# Lendo o conjunto de dados
dataset = read.csv('Data.csv')

# Dividindo o conjunto de dados em treinamento e teste 
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$DependentVariable, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Escala de atributos
training_set = scale(training_set)
test_set = scale(test_set)