all:	build
	echo "now try make run"

build:
	set -e

	# the header file gets generated
	flex  --header-file=lexer.yy.h lexer.l
	ls lexer.yy.h

	bison -d parser.y

	gcc -g -Wall -Wextra -pedantic -c lex.yy.c
	gcc -g -Wall -Wextra -pedantic -c parser.tab.c
	gcc -g -Wall -Wextra -pedantic -c main.c
	gcc -o main *.o -ll -ly

dist:	build
	cp main helloworld.`uname | tr 'A-Z' 'a-z'`

clean-temp:
	rm -fv *.yy.[ch] *.tab.[ch] *o

clean:	clean-temp
	rm -fv main *darwin

doc:
	cflow *c

run:
	echo "hello world" | ./main
