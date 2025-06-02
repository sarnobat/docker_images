cmake_minimum_required(VERSION 3.16)
project(helloworld C)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

BISON_TARGET(Parser helloworld.y ${CMAKE_CURRENT_BINARY_DIR}/helloworld.tab.c
             COMPILE_FLAGS -d)

FLEX_TARGET(Lexer helloworld.l ${CMAKE_CURRENT_BINARY_DIR}/helloworld.yy.c
            COMPILE_FLAGS --header-file=helloworld.yy.h)

ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

set(SOURCES
  main.c
  ${BISON_Parser_OUTPUT_SOURCE}
  ${FLEX_Lexer_OUTPUTS}
  ${BISON_Parser_OUTPUT_HEADER}   # ensure bison header dependency
  ${FLEX_Lexer_OUTPUT_HEADER}     # ensure flex header dependency
)

add_executable(main ${SOURCES})

target_include_directories(main PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

target_compile_options(main PRIVATE -g -Wall -Wextra -pedantic)
target_link_libraries(main PRIVATE fl y)
