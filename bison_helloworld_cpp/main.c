#include <stdio.h>

extern int yyparse(void);

int main(void) {
	printf("main()\n");

	fprintf(stderr, "[debug] %s:%d\tgoing to call yyparse()\n", __FILE__,  __LINE__);
	int status = yyparse();
	fprintf(stderr, "[debug] %s:%d\treturned from yyparse()\n", __FILE__,  __LINE__);

}

