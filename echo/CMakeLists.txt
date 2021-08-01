cmake_minimum_required(VERSION 3.12.0 )

project(echo)

set(GEN_DIR ${PROJECT_BINARY_DIR}/generated)
set(IDL_DIR ${CMAKE_CURRENT_SOURCE_DIR})

RUN_OMNIIDL(${IDL_DIR}/echo.idl ${GEN_DIR} ${IDL_DIR}/echo.idl "-Wbdebug;-Wbh='.h';-Wbs='.cpp';-Wbd='.cpp'" "echo.h;echo.cpp" SOURCE_FILES)

add_executable(echoServer echoServer.cpp ${GEN_DIR}/echo.cpp ${GEN_DIR}/echo.h)

target_link_libraries(echoServer PRIVATE ${omniORB4_LIBRARY} ${omnithread_LIBRARY} Threads::Threads)
target_include_directories(echoServer PRIVATE . ${GEN_DIR})
target_compile_options(echoServer PRIVATE)

add_executable(echoClient echoClient.cpp ${GEN_DIR}/echo.cpp ${GEN_DIR}/echo.h)

target_link_libraries(echoClient PRIVATE ${omniORB4_LIBRARY} ${omnithread_LIBRARY} Threads::Threads)
target_include_directories(echoClient PRIVATE . ${GEN_DIR})
target_compile_options(echoClient PRIVATE)

install(TARGETS echoServer DESTINATION bin)
install(TARGETS echoClient DESTINATION bin)