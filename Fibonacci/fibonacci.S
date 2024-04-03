@ Directivas minimas
    .text @ Guardar las instrucciones en la seccion de codigo
    .align 1 @ Indica que el codigo ocupa direcciones de 2^1 Byte
    .global main @ Permite que el procedimiento pueda llamarse
    .syntax unified @ Usa la sintaxis nueva de ARM thumb
    .thumb_func @ Indica que las intrucciones de la funcion son 2 Bytes
main:   @function que llama a main se llama reset_handler
    @ prologue (Creacion del marco)
    push    {r7, lr}
    sub     sp, sp, 8 @ sub sp, 8 
    add     r7, sp, 0
    @ i = 0
    movs     r3, 0
    str     r3, [r7, 4] @ [] <- Notacion de direccion
    @ stdio_init_all()
    bl      stdio_init_all
    @ while (true)
L1:
    @ fibonacci_generator()
    bl      fibonacci_generator
    str     r0, [r7, 0]
    @ printf("Fib(%u) = %u\n", i, fib_num)
    @ Los argumentos se calculan de izquierda a derecha
    ldr     r2, [r7, 0]     @ Obtener el valor de fib_num
    ldr     r1, [r7, 4]     @ Obtener el valor de 'i'
    ldr     r0, =STR1        @ Obtener la direccion de STR
    bl      printf
    @ i++
    ldr     r3, [r3, 4]
    adds    r3, 1
    str     r3, [r7, 4]
    @ if (i == 47)
    ldr     r3, [r7, 4]
    movs    r4, 47
    cmp     r3, r4
    bne     L2
    @ printf("Program stops\n")
    ldr     r0, =STR2
    bl      printf
    @ break
    b       L3
    @ else
L2:
    @ sleep_ms(1000)
    ldr     r0, DELAY
    bl      sleep_ms
    b       L1
L3:
    nop

.align 4

DELAY:       .word 1000
STR1:        .ascii "Fib(%u) = %u\012\000"   @ \012\000 es un salto de linea
STR2:        .ascii "Program stops\012\000"
    