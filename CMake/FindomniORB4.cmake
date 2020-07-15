
find_program(omniORB4_IDL_COMPILER omniidl)  # Get full path to IDL compiler

find_library(omniORB4_LIBRARY omniORB4)    
find_library(omnithread_LIBRARY omnithread)
find_library(omniCodeSets4_LIBRARY omniCodeSets4)
find_library(omniConnectionMgmt4_LIBRARY omniConnectionMgmt4)
find_library(omniDynamic4_LIBRARY omniDynamic4)
find_library(omniZIOP4_LIBRARY omniZIOP4)
find_library(omniZIOPDynamic4_LIBRARY omniZIOPDynamic4)

set(omniORB4_LIBRARIES ${omniORB4_LIBRARY} ${omnithread_LIBRARY} ${omniCodeSets4_LIBRARY} ${omniConnectionMgmt4_LIBRARY} ${omniDynamic4_LIBRARY} ${omniZIOP4_LIBRARY} ${omniZIOPDynamic4_LIBRARY})
if(omniORB4_LIBRARIES)
    message(STATUS "Found omniORB4 IDL compiler      : ${omniORB4_IDL_COMPILER}")
    message(STATUS "Found omniORB4 library           : ${omniORB4_LIBRARY}")
    message(STATUS "Found omnithread library         : ${omnithread_LIBRARY}")
    message(STATUS "Found omniCodeSets4 library      : ${omniCodeSets4}")
    message(STATUS "Found omniConnectionMgmt4 library: ${omniConnectionMgmt4}")
    message(STATUS "Found omniDynamic4 library       : ${omniDynamic4_LIBRARY}")
    message(STATUS "Found omniZIOP4 library          : ${omniZIOP4_LIBRARY}")
    message(STATUS "Found omniZIOPDynamic4 library   : ${omniZIOPDynamic4_LIBRARY}")
else()
    message(STATUS "Didn't find omniORB4")
endif(omniORB4_LIBRARIES)

macro(RUN_OMNIIDL IDL_FILE OUTPUT_DIRECTORY INCLUDE_DIRECTORY OPTIONS OUTPUT_FILES)
    file(MAKE_DIRECTORY ${OUTPUT_DIRECTORY})
    get_filename_component(IDL_FILE_BASENAME ${IDL_FILE} NAME)
    set(INTERNAL_OUTPUT_FILES ${OUTPUT_FILES})
    set(INTERNAL_OPTIONS ${OPTIONS})
    set(OUT_WITH_PATH)
    foreach (arg IN LISTS INTERNAL_OUTPUT_FILES)
        set(OUT_WITH_PATH ${OUT_WITH_PATH} ${OUTPUT_DIRECTORY}/${arg})
    endforeach ()
    ADD_CUSTOM_COMMAND(OUTPUT ${OUT_WITH_PATH}
            COMMAND ${omniORB4_IDL_COMPILER} ${OMNIIDL_PLATFORM_FLAGS} -bcxx -p${OMNI_PYTHON_RESOURCES} -I${INCLUDE_DIRECTORY} ${INTERNAL_OPTIONS} -C${OUTPUT_DIRECTORY} ${IDL_FILE}
            DEPENDS ${IDL_FILE} ${RUN_OMNIIDL_DEPS}
            COMMENT "Processing ${IDL_FILE_BASENAME}..")

    set(OUTPARAM "${ARGN}")
    foreach (loop_var IN LISTS OUTPARAM)
        set(${OUTPARAM} ${${OUTPARAM}} ${OUT_WITH_PATH})
    endforeach ()
endmacro(RUN_OMNIIDL)