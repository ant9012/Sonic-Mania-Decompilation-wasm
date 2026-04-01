set(WITH_RSDK OFF)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -O3")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -O3")

add_executable(${GAME_NAME} ${GAME_SOURCES})

set_target_properties(${GAME_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)

set(emsc_link_options
    -sSIDE_MODULE=2
    -sEXPORT_ALL=1
    -sUSE_PTHREADS=1
    -pthread
    -g
)

target_link_options(${GAME_NAME} PRIVATE ${emsc_link_options})

set_target_properties(${GAME_NAME} PROPERTIES
    SUFFIX ".wasm"
)
