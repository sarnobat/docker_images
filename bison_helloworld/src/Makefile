all:	build	run

build:
	set -e
	flex  --header-file=helloworld.yy.h helloworld.l              # Generates lex.yy.c
	bison -d helloworld.y          # Generates hello.tab.c and hello.tab.h
# 	gcc -o *h *.c
# 	gcc -g -Wall -Wextra -pedantic -MM *c

clean:

run:
	./helloworld                   # Run the parser

