#include <stdio.h>
#include "pico/stdlib.h"
#include "fibonacci_gen.h"

int main() {
    int i = 0, fib_num;
    stdio_init_all();
    // Logica dentro del bucle, configuracion afuera del bucle
    while (true) {
        fib_num = fibonacci_generator();
        printf("Fib(%u) = %u\n", i, fib_num);
        i++;
        if (i == 47) {
            printf("Program stops\n");
            break;
        }
        else
            sleep_ms(1000);
    }
}