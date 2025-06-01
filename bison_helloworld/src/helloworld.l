%{
#include "hello.tab.h"
%}

%%
hello    return HELLO;
world    return WORLD;
[ \t\n]+ ;     // Ignore whitespace
.        ;     // Ignore any other characters
%%

