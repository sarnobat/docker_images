#include <stdio.h>
#include "parser.tab.hh"
#include <FlexLexer.h>
#include "globals.h"
// extern int yyparse(void);

yyFlexLexer* currentLexer = nullptr;



int main(void) {
	printf("main()\n");

	fprintf(stderr, "[debug] %s:%d\tgoing to call yyparse()\n", __FILE__,  __LINE__);
	// int status = yyparse();

	yyFlexLexer lexer;
    currentLexer = &lexer;  // Link the global lexer

    yy::Parser parser(&lexer);


    
    
	fprintf(stderr, "[debug] %s:%d\treturned from yyparse()\n", __FILE__,  __LINE__);
	return parser.parse();



}

