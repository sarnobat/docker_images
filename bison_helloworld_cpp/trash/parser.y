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
    yy::Parser::symbol_type yylex();
}

%token HELLO WORLD

%%

greeting:
    HELLO WORLD { printf("[debug] Matched: HELLO WORLD\n"); }
  ;

%%

// Error handler required by Bison's C++ skeleton
void yy::Parser::error(const std::string& msg) {
    std::cerr << "Syntax error: " << msg << std::endl;
}
