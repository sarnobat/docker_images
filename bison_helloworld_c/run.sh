#!/bin/sh

#----------------------------------------------------------------------------
# DESCRIPTION			
# DATE				2025
# AUTHOR			ss401533@gmail.com
#----------------------------------------------------------------------------
# template found at ~/.vim/sh_header.temp

set -o errexit
echo `date +%s::`"$0" >> ~/db.git/command_history.txt >> ~/db.git/command_history_timestamped.txt

cat <<EOF | batcat --style=plain --paging=never --language sh --theme TwoDark

+ - - - - - -+     +- - - - - - - - +     + - - - - - - +
' main.c     '     ' parser.tab.c   '     ' lex.yy.c    '
'            '     '                '     '             '
' +--------+ '     ' +------------+ '     ' +---------+ '
' | main() | ' --> ' | yyparse()  | ' --> ' | yylex() | '
' +--------+ '     ' +------------+ '     ' +---------+ '
'            '     '                '     '             '
+ - - - - - -+     +- - - - - - - - +     + - - - - - - +




2025-07-04 - I'm not sure this is true anymore. The source files look the same now.


This makefile is easier to understand. 	But for latest C code, use /Volumes/git/github/2024/docker_images/bison_helloworld_cmake/src which has a bit more bison functionality and run instructions.
EOF

