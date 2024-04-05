// Para mandar a llamar funciones inline
// crear funciones a partir de funciones inline
#include <stdint.h>
#include <stdbool.h>

void gpio_set_dir_wrapper(unsigned gpio, bool out) {
    gpio_set_dir(gpio, out);
}