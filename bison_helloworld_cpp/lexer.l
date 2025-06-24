%option c++
%option noyywrap

%{
#include "parser.tab.hh"
using namespace yy;
yyFlexLexer* currentLexer = nullptr;
%}

%%
"hello"    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__,  __LINE__); return yy::Parser::token::HELLO;	}
"world"    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__,  __LINE__);	return yy::Parser::token::WORLD;	}
"[ \t\n]+" ;     // Ignore whitespace
"."        { printf("other\n"); fprintf(stderr, "[debug] %s:%d\ttoken = (anything else)\n", __FILE__,  __LINE__);}     // Ignore any other characters
%%

