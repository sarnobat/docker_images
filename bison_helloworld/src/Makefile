all:	build

build:
	set -e

	flex  --header-file=helloworld.yy.h helloworld.l

	bison -d helloworld.y

	gcc -g -Wall -Wextra -pedantic -c	lex.yy.c
	gcc -g -Wall -Wextra -pedantic -c	helloworld.tab.c
	gcc -g -Wall -Wextra -pedantic   -c -o main.o main.c
	gcc -o main *.o -ll -ly

dist:	build
	cp main helloworld.`uname | tr 'A-Z' 'a-z'`

clean-temp:
	rm -fv *.yy.[ch] *.tab.[ch] *o

clean:	clean-temp
	rm -fv main *darwin

run:
	./main
