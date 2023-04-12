# Pre-processamento

# Lendo o conjunto de dados
dataset = read.csv('Data.csv')

# Codificando dados categóricos
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))
dataset$Purchased = factor(dataset$Purchased,
                           levels = c('No', 'Yes'),
                           labels = c(0, 1))