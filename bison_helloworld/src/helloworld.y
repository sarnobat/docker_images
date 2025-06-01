
%{
#include <stdio.h>
#include <stdlib.h>
%}

%token HELLO WORLD

%%
start:
    HELLO WORLD    { printf("Hello, world parsed successfully!\n"); }
;
%%

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 1;
}
