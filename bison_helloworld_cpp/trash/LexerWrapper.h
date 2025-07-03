#ifndef LEXERWRAPPER_H
#define LEXERWRAPPER_H

#include "parser.tab.hh"
#include <FlexLexer.h>

class CustomFlexLexer : public yyFlexLexer {
public:
    CustomFlexLexer(std::istream* arg = nullptr, std::ostream* argout = nullptr)
        : yyFlexLexer(arg, argout) {}

    // Override yylex to return Bison C++ symbol_type
    yy::Parser::symbol_type yylex(yy::Parser* parser);
};

#endif
