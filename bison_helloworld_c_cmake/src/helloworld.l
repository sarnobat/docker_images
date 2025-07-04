%{
#include "helloworld.tab.h"
%}

%%
hello    { fprintf(stderr, "[debug] %s:%d hello\n", __FILE__,  __LINE__);	return HELLO;	}
world    { fprintf(stderr, "world\n");	return WORLD;	}
[ \t\n]+ ;     // Ignore whitespace
.        { printf("other\n"); fprintf(stderr, "other\n");}     // Ignore any other characters
%%

