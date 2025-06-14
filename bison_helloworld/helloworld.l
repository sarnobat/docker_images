%{
#include "helloworld.tab.h"
%}

%%
hello    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__,  __LINE__); return HELLO;	}
world    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__,  __LINE__);	return WORLD;	}
[ \t\n]+ ;     // Ignore whitespace
.        { printf("other\n"); fprintf(stderr, "[debug] %s:%d\ttoken = (anything else)\n", __FILE__,  __LINE__);}     // Ignore any other characters
%%

