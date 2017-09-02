#!/bin/sh

# Solicita que o usuario forneca um numero
read -p "Select a selectedNumber: " selectedNumber

# Funcao converte facilita obtencao da raiz
sqrt() { echo "sqrt($1)" | bc ; }

# Funcao que verifica se o numero e primo
primo()
{
# Verifica se nao e divisivel pelos primeiros numeros primos
if (( $1 % 2 != 0 )) && \
   (( $1 % 3 != 0 )) && \
   (( $1 % 5 != 0 )) && \
   (( $1 % 7 != 0 ));
then
    # Comeca em 11, pois, e o proximo numero primo apos o numero 7
    contador=11
    # Verificacao nao precisa ser maior que a raiz do numero
    local numberSqrt=`sqrt $1`
    # Continua a verificacao ate o valor superar a raiz do valor
    while (( contador <=  $numberSqrt ));
    do
        if (( $1 % contador == 0));# Verifica se e primo
        then
            echo "false" # Retorna o valor falso para a funcao
            exit 1 # Saida com erro
        fi
    contador=$(( contador + 2 ))# Evita numeros pares
    done
    echo "true" # Retorna o valor verdadeiro para a funcao
    exit 0 # Saida com sucesso
# Diz que o numero e primo se ele for o numero 2,3,5 ou 7
elif  (( $1 == 2 )) || (( $1 == 3 )) ||\
      (( $1 == 5 )) || (( $1 == 7 ));
then
    echo "true" # Retorna o valor verdadeiro para a funcao
    exit 0 # Saida com sucesso
else
    echo "false" # Retorna o valor falso para a funcao
    exit 1 # Saida com erro
fi
}

verify=2 # Inicia verificacao para a divisao pelo numero 2

while (( $selectedNumber > 1 ));
do
    # Verifica se o resultado da divisao possui resto igual a 0
    # e verifica se o divisor e um numero primo
    if (( $selectedNumber % $verify == 0 )) && \
        [ `primo $verify` = true ];
    then
        # Mostra o valor para o usuario
        echo $selectedNumber / $verify =\
            $(( $selectedNumber / $verify ))
        # Muda o valor da variavel
        selectedNumber=$(( $selectedNumber / $verify ))
    else
        # O 2 e o unico numero primo par
        if (( $verify == 2));
        then
            verify=$(( $verify + 1))
        else
            verify=$(( $verify + 2))
        fi
    fi
done
