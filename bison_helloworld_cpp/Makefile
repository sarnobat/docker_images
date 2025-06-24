all:	build
	echo "now try make run"

build:
	set -e

	# the header file gets generated
# 	/opt/homebrew/opt/flex/bin/flex --header-file=lexer.yy.hh lexer.l
# 	/opt/homebrew/opt/flex/bin/flex --header-file=lexer.yy.hh --yyclass=MyFlexLexer -o lex.yy.cc lexer.l
	/opt/homebrew/opt/flex/bin/flex --header-file=lexer.yy.hh --prefix=MyLexer -o lex.yy.cc lexer.l


	ls lexer.yy.hh

	/opt/homebrew/Cellar/bison/3.8.2/bin/bison -d -o parser.tab.cc --skeleton=lalr1.cc parser.y

	g++ -I/opt/homebrew/opt/flex/include -g -Wall -Wextra -pedantic -c lex.yy.cc -Wno-sign-compare
	g++ -g -Wall -Wextra -pedantic -c parser.tab.cc -Wno-unused-but-set-variable
	g++ -g -Wall -Wextra -pedantic -c main.cc
	g++ -o main *.o

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
