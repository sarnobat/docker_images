%option c++
%option noyywrap

%{
#include "parser.tab.hh"
#include "globals.h"

using namespace yy;
%}

%%

"hello"    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__, __LINE__); return Parser::make_HELLO(); }
"world"    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__, __LINE__); return Parser::make_WORLD(); }

[ \t\n]+   { /* skip whitespace */ }

.          { return yytext[0]; }

%%
