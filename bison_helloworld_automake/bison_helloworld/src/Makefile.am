bin_PROGRAMS = helloworld

# Compile these generated .c files + main.c
helloworld_SOURCES = main.c helloworld.tab.c helloworld.yy.c

# These files must be built before compiling sources
BUILT_SOURCES = helloworld.tab.h helloworld.tab.c helloworld.yy.c

AM_YFLAGS = -d
AM_LFLAGS = --header-file=helloworld.yy.h

# Generate Bison output files
helloworld.tab.c helloworld.tab.h: helloworld.y
	$(YACC) -d helloworld.y

# Generate Flex output file (depends on Bison header)
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
