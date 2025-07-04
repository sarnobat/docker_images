#include <stdio.h>

extern int yyparse(void);

int main(void) {
	printf("[debug] %s:%d main()\n", __FILE__,  __LINE__);
	return yyparse();
}

