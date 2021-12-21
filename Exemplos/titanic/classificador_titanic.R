# Classificador Titanic

# Lendo o conjunto de dados
dataset = read.csv('titanic.csv')
dataset = dataset[, c(2,3,5,6,7,8,10,12)]

# Codificando atributos como fatores
dataset$Sex = as.numeric(factor(dataset$Sex,
                                      levels = c('female', 'male'),
                                      labels = c(1, 2)))

dataset$Embarked = as.numeric(factor(dataset$Embarked,
                                levels = c('S', 'C', 'Q'),
                                labels = c(1, 2, 3)))

# Idades
dataset$Age[is.na(dataset$Age)] <- mean(dataset$Age, na.rm = TRUE)


# Dividindo o conjunto de dados em treinamento e teste
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Survived, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Construindo a rede neural para o conjunto de treinamento
# install.packages('h2o')
library(e1071)
classifier = svm(formula = Survived ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'radial')

# Prevendo os resultados do conjunto de teste
y_pred = as.vector(predict(classifier, newdata = test_set[-9]))

# Calculando a matriz de confusão
cm = table(test_set[, 1], y_pred)
