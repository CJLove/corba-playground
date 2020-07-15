# corba-playground
CORBA example code using [omniORB4](http://omniorb.sourceforge.net/) and configured with CMake

## CMake support for omniORB4
```
set (CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH}
                        ${CMAKE_CURRENT_SOURCE_DIR}/CMake)

find_package(omniORB4 REQUIRED)
find_package(Threads REQUIRED)
```

## IDL generation
```
RUN_OMNIIDL(IDL_FILE OUTPUT_DIRECTORY INCLUDE_DIRECTORY OPTIONS OUTPUT_FILES)
```

## Examples

### echo
Simple echo client/server
