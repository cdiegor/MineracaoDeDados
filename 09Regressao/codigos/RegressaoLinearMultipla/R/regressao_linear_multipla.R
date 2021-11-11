# Regressão Linear Múltipla

# Lendo o conjunto de dados
dataset = read.csv('50_Startups.csv')

# Codificando dados categóricos
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Dividindo o conjunto de dados em treinamento e teste 
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Escala de atributos
# training_set = scale(training_set)
# test_set = scale(test_set)

# Regressão linear múltipla no conjunto de treinamento
regressor = lm(formula = Profit ~ .,
               data = training_set)

# Prevendo os resultados no conjunto de teste
y_pred = predict(regressor, newdata = test_set)
