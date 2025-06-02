cmake_minimum_required(VERSION 3.16)
project(helloworld C)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

# Use Bison to generate parser
BISON_TARGET(Parser helloworld.y ${CMAKE_CURRENT_BINARY_DIR}/helloworld.tab.c
             DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/helloworld.tab.h)

# Use Flex to generate lexer
FLEX_TARGET(Lexer helloworld.l ${CMAKE_CURRENT_BINARY_DIR}/helloworld.yy.c
            COMPILE_FLAGS --header-file=${CMAKE_CURRENT_BINARY_DIR}/helloworld.yy.h)

# Make sure Flex depends on Bison's header
ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

# Main source
set(SOURCES
    main.c
    ${BISON_Parser_OUTPUT_SOURCE}
    ${FLEX_Lexer_OUTPUTS}
)

add_executable(helloworld ${SOURCES})

# Link libraries: fallback to -ll if FLEX_LIBRARIES is not set
if(FLEX_LIBRARIES)
    target_link_libraries(helloworld PRIVATE ${FLEX_LIBRARIES} ${BISON_LIBRARIES})
else()
    target_link_libraries(helloworld PRIVATE -ll ${BISON_LIBRARIES})
endif()

target_include_directories(helloworld PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
