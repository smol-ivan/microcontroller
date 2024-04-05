cmake_minimum_required(VERSION 3.13)

# set(PICO_SDK_PATH "home/smol/pico/pico-sdk")

include(pico_sdk_import.cmake)

project(fibonacci_project C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(PICO_BOARD pico_w)

pico_sdk_init()

add_subdirectory(Fibonacci)
add_subdirectory(hello_7segment)