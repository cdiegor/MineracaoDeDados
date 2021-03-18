# ID3 (Iterative Dichotomiser 3) 
# Implementação completa

import math
from collections import deque

class Node:
    # Guarda a informação dos nós da árvore de decisão.
    def __init__(self):
        self.value = None
        self.next = None
        self.childs = None


class DecisionTreeClassifier:
    # Classificador de árvore ID3.
    def __init__(self, X, feature_names, labels):
        self.X = X
        self.feature_names = feature_names
        self.labels = labels
        self.labelCategories = list(set(labels))
        self.labelCategoriesCount = [list(labels).count(x) for x in self.labelCategories]
        self.node = None
        self.entropy = self._get_entropy([x for x in range(len(self.labels))])  # calculates the initial entropy

    def _get_entropy(self, x_ids):
        # Calcula a entropia.
        # Parameters
        # __________
        # :param x_ids: list, Lista contendo os identificadores dos exemplos
        # __________
        # :return: entropy: float, Entropia.

        # Identificadores ordenados pela classe
        labels = [self.labels[i] for i in x_ids]
        # Conta o número de instâncias em cada classe
        label_count = [labels.count(x) for x in self.labelCategories]
        # Calcula a entropia de cada classe e soma
        entropy = sum( [-count / len(x_ids) * math.log(count / len(x_ids), 2) if count else 0 for count in label_count])
        return entropy

    def _get_information_gain(self, x_ids, feature_id):
        # Calcula o ganho de informação de um dado atributo baseado na diferença entre sua entropia e a entropia total.
        # Parameters
        # __________
        # :param x_ids: list, Lista contendo os identificadores dos exemplos
        # :param feature_id: int, Identificador do atributo
        # __________
        # :return: info_gain: float, Ganho de informação do atributo passado.

        # Calcula a entropia total
        info_gain = self._get_entropy(x_ids)
        # Guarda a lista de valores de um determinado atributo
        x_features = [self.X[x][feature_id] for x in x_ids]
        # Pega os valores únicos
        feature_vals = list(set(x_features))
        # Estabelece a frequência de cada valor
        feature_vals_count = [x_features.count(x) for x in feature_vals]
        # Pega o identificador do valor de cada atributo
        feature_vals_id = [
            [x_ids[i]
            for i, x in enumerate(x_features)
            if x == y]
            for y in feature_vals
        ]
        # Calcula o ganho de informação de um determinado atributo
        info_gain = info_gain - sum([val_counts / len(x_ids) * self._get_entropy(val_ids)
                                     for val_counts, val_ids in zip(feature_vals_count, feature_vals_id)])
        return info_gain

    def _get_feature_max_information_gain(self, x_ids, feature_ids):
        # Encontra o atributo que maximiza o ganho de informação
        # Parameters
        # __________
        # :param x_ids: list, Lista contendo as classes das instâncias
        # :param feature_ids: list, List contendo os identificadores dos atributos
        # __________
        # :returns: string and int, atributo and identificador do atributo que maximiza o ganho de informação

        # Calcula a entropia para cada atributo
        features_entropy = [self._get_information_gain(x_ids, feature_id) for feature_id in feature_ids]
        # Calcula o ganho máximo de informação
        max_id = feature_ids[features_entropy.index(max(features_entropy))]

        return self.feature_names[max_id], max_id

    def id3(self):
        # Inicializa o algoritmo ID3
        #:return: None

        x_ids = [x for x in range(len(self.X))]
        feature_ids = [x for x in range(len(self.feature_names))]
        self.node = self._id3_recv(x_ids, feature_ids, self.node)
        print('')

    def _id3_recv(self, x_ids, feature_ids, node):
        # Algoritmo ID3 recursivo.
        # Parameters
        # __________
        # :param x_ids: list, Lista contendo os identificadores dos exemplos
        # :param feature_ids: list, Lista contendo os identificadores dos atributos
        # :param node: object, O nó da árvore a ser processado
        # __________
        # :returns: Uma instância da classe nó contendo a informação da árvore ID3

        if not node:
            node = Node()  # Iniciliza o nó
        # Identificadores ordenados pela classe
        labels_in_features = [self.labels[x] for x in x_ids]
        # Se todos os exemplos forem da mesma classe (nó puro), retorna o nó com aquela classe.
        if len(set(labels_in_features)) == 1:
            node.value = self.labels[x_ids[0]]
            return node
        # Se não há mais atributos para ramificar retorna o nó com a classe mais frequente.
        if len(feature_ids) == 0:
            node.value = max(set(labels_in_features), key=labels_in_features.count)
            return node
        
        # Senão ...
        # Escolhe o atributo que maximiza o ganho de informação
        best_feature_name, best_feature_id = self._get_feature_max_information_gain(x_ids, feature_ids)
        node.value = best_feature_name
        node.childs = []
        # Valor do atributo escolhido para cada exemplo
        feature_values = list(set([self.X[x][best_feature_id] for x in x_ids]))
        # Iterar sobre todos os valores do atributo escolhido
        for value in feature_values:
            child = Node()
            child.value = value  # Adicinar um ramo para cada valor do atributo escolhido
            node.childs.append(child)  # Anexar o nó filho ao nó corrente
            child_x_ids = [x for x in x_ids if self.X[x][best_feature_id] == value]
            if not child_x_ids:
                # Se não há mais exemplos para um determinado valor não é necessária a chamada recursiva.
                child.next = max(set(labels_in_features), key=labels_in_features.count)
                print('')
            else:
                # Se há exemplos, então a chamada recursiva do algoritmo é realizada, removendo-se o atributo escolhido.
                if feature_ids and best_feature_id in feature_ids:
                    to_remove = feature_ids.index(best_feature_id)
                    feature_ids.pop(to_remove)
                # Chama o algoritmo ID3 recursivamente.
                child.next = self._id3_recv(child_x_ids, feature_ids, child.next)
        return node

    def printTree(self):
    # Imprime a árvore gerada
    #:return: None
        if not self.node:
            return
        nodes = deque()
        nodes.append(self.node)
        while len(nodes) > 0:
            node = nodes.popleft()
            print(node.value)
            if node.childs:
                for child in node.childs:
                    print('({})'.format(child.value))
                    nodes.append(child.next)
            elif node.next:
                print(node.next)
