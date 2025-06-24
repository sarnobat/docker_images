%option c++
%option noyywrap

%{

#include "parser.tab.hh"  // Bison header
#include "globals.h"

using namespace yy;  // Match your Bison namespace
%}

%%

"hello"    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__,  __LINE__); return Parser::make_HELLO(); }
"world"    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__,  __LINE__); return Parser::make_WORLD(); }

[ \t\n]+   { /* skip whitespace */ }

.          { printf("other\n"); fprintf(stderr, "[debug] %s:%d\ttoken = (anything else)\n", __FILE__,  __LINE__); return yytext[0]; }

%%

// Not used in this C++ mode, but Flex requires this definition.
int yyFlexLexer::yylex() { return 0; }

