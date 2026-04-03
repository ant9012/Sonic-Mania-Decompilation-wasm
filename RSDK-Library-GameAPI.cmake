set(WITH_RSDK OFF)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -O3")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -O3")

add_executable(${GAME_NAME} ${GAME_SOURCES})

set_target_properties(${GAME_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)

set(emsc_link_options
    # Side module configuration - KEEP IT SIMPLE
    -sSIDE_MODULE=2
    -sEXPORT_ALL=1
    
    # Memory - side modules don't control this, main module does
    # Remove TOTAL_MEMORY, ALLOW_MEMORY_GROWTH
    
    # NO single file - side modules must be separate .wasm
    # -sSINGLE_FILE=1  # REMOVE THIS
    
    # NO pthreads in side module - main module handles threading
    # -sUSE_PTHREADS=1  # REMOVE THIS
    # -sPTHREAD_POOL_SIZE=4  # REMOVE THIS
    # -pthread  # REMOVE THIS
    
    # NO async compilation for side modules
    -sBINARYEN_ASYNC_COMPILATION=0
    
    # Keep WASM
    -sWASM=1
    
    # Debug symbols (optional, remove for production)
    -g
    
    # Link-time optimization (optional)
    -flto
)

target_link_options(${GAME_NAME} PRIVATE ${emsc_link_options})

set_target_properties(${GAME_NAME} PROPERTIES
    SUFFIX ".wasm"
)
