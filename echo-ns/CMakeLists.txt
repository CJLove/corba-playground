cmake_minimum_required(VERSION 3.12.0 )

project(echo-ns)

set(GEN_DIR ${PROJECT_BINARY_DIR}/generated)
set(IDL_DIR ${CMAKE_CURRENT_SOURCE_DIR})

RUN_OMNIIDL(${IDL_DIR}/echo.idl ${GEN_DIR} ${IDL_DIR}/echo.idl "-Wbdebug;-Wbh='.h';-Wbs='.cpp';-Wbd='.cpp'" "echo.h;echo.cpp" SOURCE_FILES)

add_executable(echoNsServer echoNsServer.cpp ${GEN_DIR}/echo.cpp ${GEN_DIR}/echo.h)

target_link_libraries(echoNsServer PRIVATE ${omniORB4_LIBRARY} ${omnithread_LIBRARY} Threads::Threads)
target_include_directories(echoNsServer PRIVATE . ${GEN_DIR})
target_compile_options(echoNsServer PRIVATE)

add_executable(echoNsClient echoNsClient.cpp ${GEN_DIR}/echo.cpp ${GEN_DIR}/echo.h)

target_link_libraries(echoNsClient PRIVATE ${omniORB4_LIBRARY} ${omnithread_LIBRARY} Threads::Threads)
target_include_directories(echoNsClient PRIVATE . ${GEN_DIR})
target_compile_options(echoNsClient PRIVATE)

install(TARGETS echoNsServer DESTINATION bin)
install(TARGETS echoNsClient DESTINATION bin)
