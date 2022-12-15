%option noyywrap
%{
    #include "archivo.tab.h"    
%}

%% 
"for"                       { strcpy(yylval.cadena,yytext); return FORCICLO; }
" "+                        { strcpy(yylval.cadena,yytext); return ESPACIO; }
"{"                         { strcpy(yylval.cadena,yytext); return LLAVEA; }
"}"                         { strcpy(yylval.cadena,yytext); return LLAVEF; }
"("                         { strcpy(yylval.cadena,yytext); return PARENTESISA; }
")"                         { strcpy(yylval.cadena,yytext); return PARENTESISF; }
"="                         { strcpy(yylval.cadena,yytext); return SIGNOIGUAL; }
"+"                         { strcpy(yylval.cadena,yytext); return SIGNOMAS; } 
";"                         { strcpy(yylval.cadena,yytext); return PUNTOYCOMA; }
("<"|">"|"<="|">="|"!=")    { strcpy(yylval.cadena,yytext); return COMPARACIONSIGNO; }
("-"|"/"|"*")               { strcpy(yylval.cadena,yytext); return SIGNO; }
[a-zA-Z]([a-zA-Z]|[0-9])*   { strcpy(yylval.cadena,yytext); return IDENTIFICADOR; }
[0-9]+                      { strcpy(yylval.cadena,yytext); return ENTERO; }
\n                          { strcpy(yylval.cadena,yytext); return EOL;   }
.           {  }

%%
