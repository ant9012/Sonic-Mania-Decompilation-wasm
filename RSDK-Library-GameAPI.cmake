set(WITH_RSDK OFF)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -O3")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -O3")

add_executable(${GAME_NAME} ${GAME_SOURCES})

set_target_properties(${GAME_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)

set(emsc_link_options
    -sTOTAL_MEMORY=32MB
    -sALLOW_MEMORY_GROWTH=1
    -sWASM=1
    -sLINKABLE=1
    -sEXPORT_ALL=1
    -sSIDE_MODULE=2
    # Fix 1: Match Asyncify with the main module to prevent stack corruption
    # when async call paths cross the module boundary
    -sASYNCIFY
    -sASYNCIFY_STACK_SIZE=65536
    -sUSE_PTHREADS=1
    -sPTHREAD_POOL_SIZE=4
    -pthread
    -g
    # REMOVED: -sSINGLE_FILE=1        (meaningless on a side module)
    # REMOVED: -sBINARYEN_ASYNC_COMPILATION=0  (conflicts with pthreads + Asyncify)
)

target_link_options(${GAME_NAME} PRIVATE ${emsc_link_options})

set_target_properties(${GAME_NAME} PROPERTIES
    SUFFIX ".wasm"
)
