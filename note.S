@ Cuando se usa .'s' es para instrucciones solo de ARM y '.S' para usar 
@ instrucciones de alto nivel

@ directivas de ensamble (los programas inician con estas instrucciones)
.text @ Guardar las instrucciones en la seccion de codigo
.align 1 @ Indica que el codigo ocupa direcciones de 2^1 Byte
.global main @ Permite que el procedimiento pueda llamarse
.syntax unified @ Usa la sintaxis nueva de ARM thumb
.thumb_func @ Indica que las intrucciones de la funcion son 2 Bytes

@ Etiquetas de memoria (cada etiqueta corresponde a una direccion de memoria)
main: @Corresponde a la direccion de la funcion main
L1: @Corresponde una etiqueta de salto

@ Instrucciones thumb
@ juego de intrucciones de 16 bits!!! por eficiencia energetica
@ los mnemonicos que tienen sufijo s ex."ANDS" indican al procesador que se guarda el status

@ Estilo de compilacion
@ 1. La traduccion de una instruccion es independiente de las traducciones pasadas
@   # No asociar las variables a los registros!!!!
@ 2. Las variables y los argumentos de las funciones se guardan en la pila de la memoria
@   # En la pila se guardan variables y argumentos de la funcion (marcos de las funciones)
@ 3. Los registros 'r3 - r6' se usan como registros temporales
@ 4. El registro 'r7' se usa como apuntador de marco
@ 5. Los argumentos de las funciones se pasan en los registros 'r0-r3'
@ 6. El valor de retorno se almacena en el registro cero.

@ La pila por convencion crece hacia el cero
@ Para almacenar(reservar memoria) tenemos que restar!!!

@ Prologo (creacion marco)
@ Seccion de codigo ensamblador que contiene las instrucciones que permiten reservar memoria en la pila
@ de la memoria en la pila de la memoria de datos y respaldar los argumentos de la funcion.
@ Las funciones hoja respaldan 'lr', las hoja solo 'r7'
@ prologue
push {r7, lr}   @ respalda apuntador de marco y registro de enlace
sub sp, sp, 8   @ reserva 8bytes oara almacena variables y args
add r7, sp, 0   @ Actualiza el apuntador del marco 

@ Epilogo (destruccion del marco)
@ seccion de codigo ensamblador que contiene las instrucciones que liberan las memoria solicitada para la
@ creacion de un marco.
@ La funcion main ni requiere epilogo porque regresa el control a 'reset_handler'
@ epilogue
adds r7, r7, #24
mov  sp, r7
pop  {r7, pc}    @ pc guarda la direccion de la instruccion!!!
bx   lr          @ regresar a la direccion a la que se llamó

@Para compilar tenemos que encontrar la expresion que da el salto