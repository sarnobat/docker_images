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
    yy::Parser::symbol_type yylex();  // No parameters!
}

%token HELLO WORLD

%{
#include <execinfo.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

#include "lexer.yy.hh"



/* Obtain a backtrace and print it to stdout. */
void
print_trace (void)
{
  void *array[10];
  char **strings;
  int size, i;

  size = backtrace (array, 10);
  strings = backtrace_symbols (array, size);
  if (strings != NULL)
  {

    printf ("Obtained %d stack frames.\n", size);
    for (i = 0; i < size; i++)
      printf ("%s\n", strings[i]);
  }

  free (strings);
}


%}


%%
start:
    HELLO WORLD    {
//      fprintf(stderr, "[debug] %s:%d production HELLO WORLD detected %d\n", __FILE__,  __LINE__, $$, yyla);
      fprintf(stderr, "[debug] %s:%d production HELLO WORLD detected %d %d\n",
        __FILE__, __LINE__, yylhs.value.as<int>(), yyla.value.as<int>());

      print_trace();
    }
;
%%
yy::Parser::symbol_type yylex() {
    return currentParser->lexer_->yylex();  // assuming you track the parser globally
}

void yy::Parser::error(const std::string& msg) {
    std::cerr << "Syntax error: " << msg << std::endl;
}
