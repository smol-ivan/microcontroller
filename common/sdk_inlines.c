// Para mandar a llamar funciones inline
// crear funciones a partir de funciones inline
#include <stdint.h>
#include <stdbool.h>

void gpio_set_dir_wrapper(unsigned gpio, bool out) {
    gpio_set_dir(gpio, out);
}

void gpio_pull_up_wrapper(unsigned gpio) {
    gpio_pull_up(gpio);
}

bool gpio_get_wrapper(unsigned gpio) {
    gpio_get(gpio);
}

void gpio_set_mask_wrapper(uint32_t mask) {
    gpio_set_mask(mask);
}

void gpio_clr_mask_wrapper(uint32_t mask) {
    gpio_clr_mask(mask);
}