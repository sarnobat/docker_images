%skeleton "lalr1.cc"
%language "C++"
%define api.namespace {yy}
%define api.parser.class {Parser}
%define api.token.constructor
%define api.value.type variant
%parse-param { yyFlexLexer* lexer }

%code requires {
    class yyFlexLexer;
}

%code {
    yy::Parser::symbol_type yylex();  // Free function, not a method
}

%token HELLO WORLD

%%

greeting:
    HELLO WORLD { printf("[debug] Matched: HELLO WORLD\n"); }
  ;

%%

#include "globals.h"

// Define yylex as a free function
yy::Parser::symbol_type yylex() {
    return currentLexer->yylex();
}

// Required error handler
void yy::Parser::error(const std::string& msg) {
    std::cerr << "Syntax error: " << msg << std::endl;
}
