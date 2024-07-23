%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
char* traduzir_peca(char peca);

%}

%union {
    char peca;
    char coluna;
    char linha;
    char *texto;
}

%token <peca> PECA
%token <coluna> COLUNA
%token <linha> LINHA
%token CAPTURA
%token ROQUE_PEQUENO ROQUE_GRANDE
%token CHEQUE MATE
%token ESPACO
%type <texto> posicao_final

%%

jogadas:
    movimento ESPACO jogadas   { /* Várias jogadas */ }
    | movimento                { /* Única jogada */ }
    ;

movimento:
    ROQUE_PEQUENO                        { printf("Roque pequeno\n"); }
    | ROQUE_GRANDE                       { printf("Roque grande\n"); }
    | PECA COLUNA LINHA posicao_final    { printf("%s para %c%c%s\n", traduzir_peca($1), $2, $3, $4); }
    | PECA COLUNA COLUNA LINHA posicao_final    { printf("%s em %c para %c%c%s\n", traduzir_peca($1), $2, $3, $4, $5); }
    | PECA CAPTURA COLUNA LINHA posicao_final { printf("%s captura em %c%c%s\n", traduzir_peca($1), $3, $4, $5); }
    | PECA COLUNA CAPTURA COLUNA LINHA posicao_final { printf("%s em %c captura em %c%c%s\n", traduzir_peca($1), $2, $4, $5, $6); }
    | COLUNA LINHA posicao_final         { printf("Peão para %c%c%s\n", $1, $2, $3); }
    | COLUNA CAPTURA COLUNA LINHA posicao_final { printf("Peão captura em %c%c%s\n", $3, $4, $5); }
    ;

posicao_final:
    CHEQUE { $$ = " (xeque)"; }
    | MATE { $$ = " (mate)"; }
    | /* vazio */ { $$ = ""; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

char* traduzir_peca(char peca) {
    switch (peca) {
        case 'K': return "Rei";
        case 'Q': return "Rainha";
        case 'R': return "Torre";
        case 'B': return "Bispo";
        case 'N': return "Cavalo";
        default: return "Peça desconhecida";
    }
}
