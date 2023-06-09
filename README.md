Acelerador para Retirar Ruido de Imagem 

Este projeto constitui em um acelerador para o algoritmo do filtro de mediana usado para remoção de ruído em imagens (RIBEIRO, B., 2022).
O acelerador permite operar em três modos selecionáveis pelo usuário:  3x3, 5x5 e 9x9.

Funcionamento

O cerne do filtro de mediana implementa uma lógica para ordenamento sobre os elementos da janela de amostragem. Com isso, foi retirado do software (em C++) o ordenamento da janela (uma matriz) e implementado por hardware no acelerador, utilizando VHDL. Assim, o acelerador recebe pixel por pixel da janela sendo filtrada. A cada linha gerada pela recepção dos pixels é realizada o ordenamento por Quicksort e o cálculo da mediana da linha. Cada mediana é armazenada em um vetor que no final também é ordenado por Quicksort e calculado a mediana das medianas. A mediana final é retornada para o software que prossegue sua execução.
