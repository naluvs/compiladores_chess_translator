# Chess Move Translator

## Descrição

Este projeto implementa um tradutor de notação de xadrez para português (PT-BR) usando Flex (um gerador de analisadores léxicos) e Bison (um gerador de analisadores sintáticos). Ele aceita múltiplas jogadas de xadrez em uma única linha e as traduz para português, exibindo cada jogada em uma linha separada.

## Requisitos

- Flex
- Bison
- GCC
- Linux

## Compilar

1. bison -d chess.y
2. flex chess.l
3. gcc -o chess_translator chess.tab.c lex.yy.c main.c -lfl

## Executar

./chess_translator
