cmake_minimum_required(VERSION 3.12.0 )

project(corba-playground)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set (CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH}
                        ${CMAKE_CURRENT_SOURCE_DIR}/CMake)

set (CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/build)

find_package(omniORB4 REQUIRED)
find_package(Threads REQUIRED)

add_definitions(-std=c++11)

add_subdirectory(echo)

add_subdirectory(echo-ns)

