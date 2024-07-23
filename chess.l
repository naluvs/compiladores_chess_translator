%{
#include "chess.tab.h"
%}

%%

O-O-O         { return ROQUE_GRANDE; }
O-O           { return ROQUE_PEQUENO; }
[KQRBN]       { yylval.peca = yytext[0]; return PECA; }
[a-h]         { yylval.coluna = yytext[0]; return COLUNA; }
[1-8]         { yylval.linha = yytext[0]; return LINHA; }
x             { return CAPTURA; }
\+            { return CHEQUE; }
\#            { return MATE; }
[ \t\n]       { return ESPACO; }  
.|\n          { /* Ignore others */ }

%%

int yywrap() {
    return 1;
}
