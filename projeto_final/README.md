# Jogo da forca Shell Script

## Funcionamento do jogo

O jogo da força é um jogo em que o jogador tem que acertar qual é a palavra proposta, tendo como dica o número de letras. A cada letra errada, um erro é mostrado para o usuário. No modo single o usuário tem um número limitado de tentativas, a cada erro esse número é decrementado. Já no modo competition dois usuários jogam com um número ilimitado de tentativas, ganhando quem acertar todas as palavras com menos tentativas.

## Modos de execução

O script recebe alguns dados como parâmetros, especificados na tabela abaixo.

Parâmetro | Descrição
:---------: | ------
-f        | Arquivo de palavras
-t        | Número de tentativas
-c        | Modo competição

Para executar o modo single, execute o seguinte comando: **./forca.sh -f <arquivo.txt> -t <Número de Tentativas>**

Já o modo competition, execute o seguinte comando: **./forca.sh -f <arquivo.txt> -c**
