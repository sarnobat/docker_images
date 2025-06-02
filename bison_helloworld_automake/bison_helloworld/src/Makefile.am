bin_PROGRAMS = helloworld

helloworld_SOURCES = main.c helloworld.l helloworld.y

BUILT_SOURCES = helloworld.tab.h

AM_YFLAGS = -d
AM_LFLAGS = --header-file=helloworld.yy.h

# Bison generates these
helloworld.tab.c helloworld.tab.h: helloworld.y
	$(YACC) -d helloworld.y

# Flex depends on Bison header
helloworld.l: helloworld.tab.h

# Flex rule
helloworld.yy.c: helloworld.l helloworld.tab.h
	$(LEX) $(AM_LFLAGS) helloworld.l

CLEANFILES = *.tab.c *.tab.h *.yy.c *.yy.h *.o helloworld *darwin

EXTRA_DIST = helloworld.l helloworld.y main.c

dist-hook:
	cp helloworld helloworld.$(shell uname | tr 'A-Z' 'a-z')

doc:
	cflow *.c

run:
	./helloworld
