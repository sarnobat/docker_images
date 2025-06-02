cmake_minimum_required(VERSION 3.16)
project(helloworld C)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

# Generate parser files
BISON_TARGET(Parser helloworld.y ${CMAKE_CURRENT_BINARY_DIR}/helloworld.tab.c
             COMPILE_FLAGS -d)

# Generate lexer files, depends on parser header
FLEX_TARGET(Lexer helloworld.l ${CMAKE_CURRENT_BINARY_DIR}/helloworld.yy.c
            COMPILE_FLAGS --header-file=helloworld.yy.h)
ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

# Sources
set(SOURCES
  main.c
  ${BISON_Parser_OUTPUT_SOURCE}
  ${FLEX_Lexer_OUTPUTS}
)

add_executable(main ${SOURCES})

target_include_directories(main PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

target_compile_options(main PRIVATE -g -Wall -Wextra -pedantic)

target_link_libraries(main PRIVATE fl y)

# Custom target to copy the binary with lowercase uname output (dist)
add_custom_target(dist
  COMMAND ${CMAKE_COMMAND} -E copy
    $<TARGET_FILE:main>
    helloworld.$(shell uname | tr 'A-Z' 'a-z')
  DEPENDS main
)

# Custom target for cleaning generated files (similar to clean-temp)
add_custom_target(clean-temp
  COMMAND ${CMAKE_COMMAND} -E rm -f
    ${CMAKE_CURRENT_BINARY_DIR}/*.yy.c
    ${CMAKE_CURRENT_BINARY_DIR}/*.yy.h
    ${CMAKE_CURRENT_BINARY_DIR}/*.tab.c
    ${CMAKE_CURRENT_BINARY_DIR}/*.tab.h
    ${CMAKE_CURRENT_BINARY_DIR}/*.o
)

# Add 'run' target to execute the program
add_custom_target(run
  COMMAND main
  DEPENDS main
)
