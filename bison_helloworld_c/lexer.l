%{
// This is a circular dependency. The output file needs this even though only bison generates it
#include "parser.tab.h"
%}

%%
hello    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__,  __LINE__); return HELLO;	}
world    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__,  __LINE__);	return WORLD;	}
[\n]     { fprintf(stderr, "[debug] %s:%d\ttoken = newline\n", __FILE__,  __LINE__);	return NEWLINE;	}
[ \t]+ ;     // Ignore whitespace
.        { printf("other\n"); fprintf(stderr, "[debug] %s:%d\ttoken = (anything else)\n", __FILE__,  __LINE__);}     // Ignore any other characters
%%

