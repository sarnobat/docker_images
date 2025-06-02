%{
# without stdio, printf to stderr doesn't work but no error is shown
#include <stdio.h>
#include "helloworld.tab.h"
%}

%%
hello    { printf(stderr, "hello\n");	return HELLO;	}
world    { printf(stderr, "world\n");	return WORLD;	}
[ \t\n]+ ;     // Ignore whitespace
.        { printf("other\n"); printf(stderr, "other\n");}     // Ignore any other characters
%%

