#include <stdio.h>

extern int yyparse(void);

int main(void) {
	printf("main()\n");
	return yyparse();
}

