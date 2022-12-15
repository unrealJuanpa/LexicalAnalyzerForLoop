%{
    #include <stdio.h>
    #include <string.h>

    char codigotresvias[1024];
    char tempCad[200] = "";
    char tempCad2[200] = "";
    char tempCad3[200] = "";

    int ctemp = 1;

    void yyerror(char *mensaje);
    int yylex();

    const char* conversiondesimbolo(char* signo) {
        if (strcmp(signo, "<") == 0) {
            return ">=";
        }
        if (strcmp(signo, ">") == 0) {
            return "<=";
        }
        if (strcmp(signo, "<=") == 0) {
            return ">";
        }
        if (strcmp(signo, ">=") == 0) {
            return "<";
        }
        if (strcmp(signo, "==") == 0) {
            return "!=";
        }
        if (strcmp(signo, "!=") == 0) {
            return "==";
        }
        return "";
    }

    void parseOperacion(char* operacion) {
        int idxpor = -1;
        int t1 = -1;
        int t2 = -1;
        int j = 0;

        for (int i = 0; i < strlen(operacion); i++) {
            

            if (operacion[i] == '*' || operacion[i] == '/') {
                for (j = i; j > 0; j--) {
                    if (operacion[j] == '*' || operacion[j] == '/' || operacion[j] == '-' || operacion[j] == '+') {
                        break;
                    }
                }

                t1 = j;

                for (j = i; j < strlen(operacion); j++) {
                    if (operacion[j] == '*' || operacion[j] == '/' || operacion[j] == '-' || operacion[j] == '+') {
                        j--;
                        break;
                    }
                }

                t2 = j;

                for (j = t1; j <= t2; j++) {
                    tempCad3[j-t1] = operacion[j];
                }

                tempCad3[j-t1] = '\0';

                

                strcat(codigotresvias, "\t");
                sprintf(codigotresvias, "t%i=%s", ctemp++, tempCad3);
                break;
            }
        }
    }
%}

%union{
    char cadena[50];
}

%token <cadena>FORCICLO
%token <cadena>ESPACIO
%token <cadena>LLAVEA
%token <cadena>LLAVEF
%token <cadena>PARENTESISA
%token <cadena>PARENTESISF
%token <cadena>SIGNOIGUAL
%token <cadena>SIGNOMAS
%token <cadena>PUNTOYCOMA
%token <cadena>COMPARACIONSIGNO
%token <cadena>SIGNO
%token <cadena>IDENTIFICADOR
%token <cadena>ENTERO
%token <cadena>EOL

%type <cadena> inicio
%type <cadena> ceroomasespacios
%type <cadena> unaomaseol
%type <cadena> operacion
%type <cadena> asignacion
%type <cadena> mifor

%%
inicio      : mifor           { printf("Sintaxis correcta!\n"); }
            ;

ceroomasespacios    : ESPACIO { strcpy($$, ""); strcat($$, $1); }
                    | 
                    ;

unaomaseol          : EOL unaomaseol
                    | 
                    ;

operacion           : SIGNO ceroomasespacios ENTERO operacion { strcat($$, $3); strcat($$, $4);  }
                    | SIGNO ceroomasespacios IDENTIFICADOR operacion { strcat($$, $3); strcat($$, $4); }
                    | SIGNOMAS ceroomasespacios ENTERO operacion { strcat($$, $3); strcat($$, $4); }
                    | SIGNOMAS ceroomasespacios IDENTIFICADOR operacion { strcat($$, $3); strcat($$, $4); }
                    | 
                    ;

asignacion          : ceroomasespacios IDENTIFICADOR ceroomasespacios SIGNOIGUAL ceroomasespacios IDENTIFICADOR operacion PUNTOYCOMA unaomaseol asignacion { strcat(tempCad, $2); strcat(tempCad, $4); strcat(tempCad, $6); strcat(tempCad, $7); parseOperacion(tempCad); }
                    | ceroomasespacios IDENTIFICADOR ceroomasespacios SIGNOIGUAL ceroomasespacios ENTERO operacion PUNTOYCOMA unaomaseol asignacion { strcat(tempCad, $2); strcat(tempCad, $4); strcat(tempCad, $6); strcat(tempCad, $7); parseOperacion(tempCad); }
                    | 
                    ;

mifor       : FORCICLO ceroomasespacios PARENTESISA ceroomasespacios IDENTIFICADOR ceroomasespacios SIGNOIGUAL ceroomasespacios ENTERO PUNTOYCOMA ceroomasespacios IDENTIFICADOR ceroomasespacios COMPARACIONSIGNO ceroomasespacios ENTERO ceroomasespacios PUNTOYCOMA ceroomasespacios IDENTIFICADOR ceroomasespacios SIGNOMAS SIGNOMAS ceroomasespacios PARENTESISF ceroomasespacios LLAVEA unaomaseol asignacion LLAVEF { strcpy(codigotresvias, ""); sprintf(codigotresvias, "t%i=%s\nL1: if t%i %s %s goto L2\n", ctemp, $9, ctemp, conversiondesimbolo($14), $16); ctemp++; }
            ;

%%

void yyerror(char *mensaje) {
    fprintf(stderr, "Error: %s\n", mensaje);
}

int main() {
    yyparse();

    printf("Codigo de tres vias generado:\n");
    printf(codigotresvias);
    return 0;
}
