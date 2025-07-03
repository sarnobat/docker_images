#include "LexerWrapper.h"
#include "parser.tab.hh"

yy::Parser::symbol_type CustomFlexLexer::yylex(yy::Parser* parser) {
    return yy::yylex();  // Call the global yylex function defined for Bison
}
