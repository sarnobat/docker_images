
%{
#include <execinfo.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

#include "lexer.yy.h"

int yyerror(const char *s);


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

%token HELLO WORLD NEWLINE

%%
start:
    HELLO WORLD    {
      fprintf(stderr, "[debug] %s:%d production HELLO WORLD detected %d\n", __FILE__,  __LINE__, $$, yylval);
      print_trace();
    }
    NEWLINE {fprintf(stderr, "[debug] %s:%d production NEWLINE detected %d\n", __FILE__,  __LINE__, $$, yylval);
      print_trace();
    }
;
%%

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 1;
}
