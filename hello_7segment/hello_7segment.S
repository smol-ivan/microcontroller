@ directivas de ensamble (los programas inician con estas instrucciones)
.text @ Guardar las instrucciones en la seccion de codigo
.align 1 @ Indica que el codigo ocupa direcciones de 2^1 Byte
.global main @ Permite que el procedimiento pueda llamarse
.syntax unified @ Usa la sintaxis nueva de ARM thumb
.thumb_func @ Indica que las intrucciones de la funcion son 2 Bytes
.equ FIRST_GPIO, 2
.equ BUTTON_GPIO, FIRST_GPIO+7 
.equ GPIO_OUT, 1
.equ GPIO_IN, 0
.equ GPIO_OVERRIDE_INVERT, 0
main:
    @ prologue
    push    {r7, lr}
    sub     sp, 56
    mov     r7, sp
    @ array initialization
    ldr     r0, =BITS   @ gets BITS address
    mov     r1, r7      @ gets the array's base address
    ldmia   r0!, {r2, r3, r4, r5, r6}   @ Guarda registros de p*tazo
    stmia   r1!, {r2, r3, r4, r5, r6}   @ Carga valores en la pila
    ldmia   r0!, {r2, r3, r4, r5, r6}  
    stmia   r1!, {r2, r3, r4, r5, r6}
    @ stdio_init_all()
    bl      stdio_init_all
    @ printf("Hello, 7segment - press button to count down!\n")
    ldr     r0, =STR1    @ obtner la direccion de STR
    bl      printf  
    @ for loop
    @ iterator's init
    movs    r3, FIRST_GPIO
    str     r7, [r7, 40]
    b       L1 @ salto incondicional
    @ loop's body
L2:
    @ gpio_init(gpio) todo
    ldr     r0, [r7, 40]    @ carga gpio
    bl      gpio_init
    @ gpio_set_dir(gpio, GPIO_OUT)
    movs    r1, GPIO_OUT
    ldr     r0, [r7, 40]
    bl      gpio_set_dir_wrapper
    @ gpio_set_outover(gpio, GPIO_OVERRIDE_INVERT) todo
    movs    r1, GPIO_OVERRIDE_INVERT
    ldr     r0, [r7, 40]
    bl      gpio_set_outover
    @ gpio ++
    ldr     r3, [r7, 40]    @carga gpio
    adds    r3, 1           @procesa gpio gpio++
    str     r3, [r7, 40]    @almacena gpio actualizado
    @ gpio < FIRST_GPIO + 7
L1:
    ldr     r3, [r7, 40]
    cmp     r3, 9
    blt     L2
    @ gpio_init(BUTTON_GPIO) todo
    movs    r0, BUTTON_GPIO
    bl      gpio_init
    @ gpio_set_dir_wrapper(BUTTON_GPIO, GPIO_IN) todo
    movs    r1, GPIO_IN
    movs    r0, BUTTON_GPIO
    bl      gpio_set_dir_wrapper
    @ gpio_pull_up_wrapper(BUTTON_GPIO)
    movs    r0, BUTTON_GPIO
    bl      gpio_pull_up_wrapper
    @ val = 0 todo
    movs    r3, 0
    str     r3, [r7, 44]
    @ while loop
L4:

    @ mask = bits[val] << FIRST_GPIO
    mov     r3, r7          @ gets bit's base address
    ldr     r4, [r7, 44]    @ gets val's value
    lsls    r4, 2           @ computes 4 * val
    ldr     r3, [r3, r4]    @ add base address and 4*val(offset)
    lsls    r3, FIRST_GPIO  @ bits[val] << FIRST_GPIO
    str     r3, [r7, 48]

    b       L4




.section    .rodata @read only data
.align 2
BITS:   
    .word   0x3f
    .word   0x06
    .word   0x5b
    .word   0x4f
    .word   0x66
    .word   0x6d
    .word   0x7d
    .word   0x07
    .word   0x7f
    .word   0x67

.align 4
STR1:        .ascii "Hello, 7segment - press button to count down!\012\000"