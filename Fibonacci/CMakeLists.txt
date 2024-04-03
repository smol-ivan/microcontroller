cmake_minimum_required(VERSION 3.13)

add_executable(Fibonacci
    fibonacci.c
    fibonacci_gen.c
)

pico_enable_stdio_usb(Fibonacci 1)
pico_enable_stdio_uart(Fibonacci 0)

pico_add_extra_outputs(Fibonacci)

target_link_libraries(Fibonacci pico_stdlib)