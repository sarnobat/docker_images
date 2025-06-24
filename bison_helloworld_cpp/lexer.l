%option c++
%option noyywrap

%{
// This is a circular dependency. The output file needs this even though only bison generates it
#include "parser.tab.hh"
//using namespace myparser;  // Optional for shorthand
%}

%%
"hello"    { fprintf(stderr, "[debug] %s:%d\ttoken = hello\n", __FILE__,  __LINE__); return yy::Parser::token::HELLO;	}
"world"    { fprintf(stderr, "[debug] %s:%d\ttoken = world\n", __FILE__,  __LINE__);	return yy::Parser::token::WORLD;	}
"[ \t\n]+" ;     // Ignore whitespace
"."        { printf("other\n"); fprintf(stderr, "[debug] %s:%d\ttoken = (anything else)\n", __FILE__,  __LINE__);}     // Ignore any other characters
%%

