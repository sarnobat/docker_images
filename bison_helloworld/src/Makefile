all:	build

build:
	set -e
	flex  --header-file=helloworld.yy.h helloworld.l              # Generates lex.yy.c
	bison -d helloworld.y          # Generates hello.tab.c and hello.tab.h
# 	helloworld.tab.c
# 	gcc -g -Wall -Wextra -pedantic -MM	*.c
	gcc -g -Wall -Wextra -pedantic -c	lex.yy.c
# 	gcc -g -Wall -Wextra -pedantic -c	helloworld.tab.c
	# -c     Run all of the above, plus the assembler, generating a target ".o" object file.
# 	gcc -g -Wall -Wextra -pedantic   -c -o main.o main.c
# 	gcc -o main lex.yy.o main.o -ll -ly
# 	gcc *h *.c
# 	gcc -g -Wall -Wextra -pedantic -MM *c

clean:
	rm -v *.yy.[ch] *.tab.[ch] # *.o 

run:
	./helloworld                   # Run the parser

