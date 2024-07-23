#include <stdio.h>
#include <string.h>

extern int yyparse();
extern void yyrestart(FILE *input_file);
extern FILE *yyin;

int main() {
    char entrada[3000];

    while (1) {
        printf("Digite os movimentos de xadrez (ou 'sair' para terminar): ");
        if (fgets(entrada, sizeof(entrada), stdin) == NULL) {
            break;
        }

        // Remove a nova linha do final da entrada
        entrada[strcspn(entrada, "\n")] = '\0';

        // Verifica se o usuário deseja sair
        if (strcmp(entrada, "sair") == 0) {
            break;
        }

        // Cria um arquivo de memória com a entrada
        FILE *input = fmemopen(entrada, strlen(entrada), "r");
        yyrestart(input);
        yyparse();
        fclose(input);
    }

    return 0;
}