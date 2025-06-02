bin_PROGRAMS = helloworld

helloworld_SOURCES = main.c helloworld.l helloworld.y

BUILT_SOURCES = helloworld.tab.h

AM_YFLAGS = -d
AM_LFLAGS = --header-file=helloworld.yy.h

# Explicit rule for header
helloworld.tab.h: helloworld.y
	$(YACC) -d helloworld.y

# Flex must wait for Bison's header
helloworld.yy.c: helloworld.tab.h

CLEANFILES = *.tab.c *.tab.h *.yy.c *.yy.h *.o helloworld *darwin

EXTRA_DIST = helloworld.l helloworld.y main.c

dist-hook:
	cp helloworld helloworld.$(shell uname | tr 'A-Z' 'a-z')

doc:
	cflow *.c

run:
	./helloworld
