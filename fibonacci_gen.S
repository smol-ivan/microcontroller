@ Directivas minimas
    .text @ Guardar las instrucciones en la seccion de codigo
    .align 1 @ Indica que el codigo ocupa direcciones de 2^1 Byte
    .global fibonacci_generator @ Permite que el procedimiento pueda llamarse
    .syntax unified @ Usa la sintaxis nueva de ARM thumb
    .thumb_func @ Indica que las intrucciones de la funcion son 2 Bytes
fibonacci_generator:
    @ prologue
    push    {r7}
    add     sp, 4
    add     r7, sp, 0
    @ temp = a
    ldr     r3, =a_var  @ almacena la direccion de a_var
    ldr     r3, [r3]    @ carga el valor de a_var
    str     r3, [r7]    @ Almacena el valor de a_var en temp
    @ a = b
    ldr     r3, =b_var
    ldr     r3, [r3]
    ldr     r4, =a_var
    str     r3, [r4]
    @ b = b + temp
    ldr     r3, =b_var
    ldr     r3, [r3]
    ldr     r4, [r7]
    add     r3, r4
    ldr     r4, =b_var
    str     r3, [r4]
    @ return a
    ldr     r3, =a_var
    ldr     r0, [r3]
    @ epilogue
    adds     r7, 4
    mov     sp, r7
    pop     {r7, pc}
    bx      lr

.data
    .align  2 @ Alinear la memoria de datos a bloque de 2^2 Bytes
a_var:
    .word   0
b_var:
    .word   1
