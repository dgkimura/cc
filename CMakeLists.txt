cmake_minimum_required(VERSION 3.4)
project(cc)

find_package(BISON)
find_package(FLEX)

bison_target(MyParser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.c)
flex_target(MyScanner tokens.l ${CMAKE_CURRENT_BINARY_DIR}/tokens.c)
add_flex_bison_dependency(MyScanner MyParser)

include_directories(${CMAKE_BINARY_DIR})

add_executable(cc ${BISON_MyParser_OUTPUTS} ${FLEX_MyScanner_OUTPUTS} main.c)
