all:	build	run

build:
	set -e
	flex helloworld.l              # Generates lex.yy.c
	bison -d helloworld.y          # Generates hello.tab.c and hello.tab.h
# 	gcc -o helloworld lex.yy.c helloworld.tab.c -lfl
# 	gcc -g -Wall -Wextra -pedantic -MM *c

clean:

run:
	./helloworld                   # Run the parser

