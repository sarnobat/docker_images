all:	build
	echo "now try make run"

build:
	set -e

	# the header file gets generated
	flex  --header-file=lexer.yy.h lexer.l
	ls lexer.yy.h

	bison -d parser.y

	g++ -g -Wall -Wextra -pedantic -c lex.yy.c
	g++ -g -Wall -Wextra -pedantic -c parser.tab.c
	g++ -g -Wall -Wextra -pedantic -c main.c
	g++ -o main *.o -ll -ly

dist:	build
	cp main helloworld.`uname | tr 'A-Z' 'a-z'`

clean-temp:
	rm -fv *.yy.cc *.yy.hh *.tab.cc *.tab.hh *o stack.hh

clean:	clean-temp
	rm -fv main *darwin

doc:
	cflow *c

run:
	echo "hello world" | ./main
