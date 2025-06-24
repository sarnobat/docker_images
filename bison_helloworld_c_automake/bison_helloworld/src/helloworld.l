%{
#include "helloworld.tab.h"
%}

%%
hello    return HELLO;
world    return WORLD;
[ \t\n]+ ;     // Ignore whitespace
.        { printf("other\n");}     // Ignore any other characters
%%

