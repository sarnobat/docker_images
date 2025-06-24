#include "parser.tab.hh"
#include "globals.h"

yyFlexLexer* currentLexer = nullptr;

int main() {
    yyFlexLexer lexer;
    currentLexer = &lexer;

    yy::Parser parser(&lexer);
    return parser.parse();
}
