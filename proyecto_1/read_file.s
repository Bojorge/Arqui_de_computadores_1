.arch armv7-a
.cpu cortex-a7
.fpu vfpv3
.eabi_attribute 67, "2.09"
.eabi_attribute 6, 10

.section .data
    k: .float 2205
    alpha: .float 0.6
    name_input: .asciz "samples.bin"
    name_output_add_reverberizacion: .asciz "output_reverberizado.bin"
    name_output_reduce_reverberizacion: .asciz "output_sin_reverberizado.bin"    

    .align 2
    buffer_input: .space 1608192
    buffer_output: .space 1608192

.section .text
.global _start

_start:
    ldr r3, =#k              @ Cargar el valor de k
    ldr r4, =#alpha          @ Cargar el valor de alpha
    mov r5, #0               @ Inicializar el contador i
    mov r6, #0               @ Inicializar el índice del buffer circular

    @ Abrir el archivo de entrada
    mov r7, #0x5            @ código de la llamada al sistema para abrir
    ldr r0, =name_input     @ nombre del archivo de entrada
    mov r1, #2              @ configuración para abrir (O_RDONLY)
    mov r2, #0              @ modo predeterminado
    swi 0                   @ llamada al sistema para abrir el archivo de entrada

    @ Leer desde el archivo de entrada al buffer de entrada
    mov r7, #0x3            @ código para la llamada al sistema read
    ldr r1, =buffer_input   @ dirección del buffer de entrada
    ldr r2, =#1608192         @ tamaño del buffer de entrada
    swi 0                   @ llamada al sistema para leer
    
    @ Aplicar la reverberación a las muestras de entrada
    bl add_reverberation

    @ Abrir el archivo de salida resultado reverberizado
    mov r7, #0x5            			@ código de la llamada al sistema para abrir
    ldr r0, =name_output_add_reverberizacion    @ nombre del archivo de salida
    mov r1, #66            		 @ configuración para abrir (O_WRONLY|O_CREAT|O_TRUNC)
    mov r2, #438           		 @ permisos para el archivo de salida (0666 en octal)
    swi 0                   		 @ llamada al sistema para abrir el archivo de salida

    @ Escribir desde el buffer de entrada al archivo de salida
    mov r7, #0x4            	@ código para la llamada al sistema write
    ldr r1, =buffer_output   	@ dirección del buffer de salida
    ldr r2, =1608192          	@ tamaño del buffer de entrada
    swi 0                   	@ llamada al sistema para escribir en el archivo de salida
    
    @ Cerrar el archivo de entrada
    mov r7, #6              @ código de la llamada al sistema para cerrar
    swi 0                   @ llamada al sistema para cerrar el archivo de entrada

        @ Cerrar el archivo de salida
    mov r7, #6              @ código de la llamada al sistema para cerrar
    swi 0   


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    ldr r3, =#k              @ Cargar el valor de k
    ldr r4, =#alpha          @ Cargar el valor de alpha
    mov r5, #0               @ Inicializar el contador i
    mov r6, #0               @ Inicializar el índice del buffer circular

    @ Abrir el archivo de entrada
    mov r7, #0x5            @ código de la llamada al sistema para abrir
    ldr r0, =name_input     @ nombre del archivo de entrada
    mov r1, #2              @ configuración para abrir (O_RDONLY)
    mov r2, #0              @ modo predeterminado
    swi 0                   @ llamada al sistema para abrir el archivo de entrada

    @ Leer desde el archivo de entrada al buffer de entrada
    mov r7, #0x3            @ código para la llamada al sistema read
    ldr r1, =buffer_input   @ dirección del buffer de entrada
    ldr r2, =#1608192         @ tamaño del buffer de entrada
    swi 0                   @ llamada al sistema para leer
    

    @ Aplicar la reducción de la reverberación al buffer de salida 1
    bl reduce_reverberation
    
    @ Abrir el archivo de salida resultado no reverberizado
    mov r7, #0x5            			@ código de la llamada al sistema para abrir
    ldr r0, =name_output_reduce_reverberizacion    @ nombre del archivo de salida
    mov r1, #66            		 @ configuración para abrir (O_WRONLY|O_CREAT|O_TRUNC)
    mov r2, #438           		 @ permisos para el archivo de salida (0666 en octal)
    swi 0                   		 @ llamada al sistema para abrir el archivo de salida

    @ Escribir desde el buffer de entrada al archivo de salida
    mov r7, #0x4            	@ código para la llamada al sistema write
    ldr r1, =buffer_output   	@ dirección del buffer de salida
    ldr r2, =1608192          	@ tamaño del buffer de entrada
    swi 0                   	@ llamada al sistema para escribir en el archivo de salida

    @ Cerrar el archivo de entrada
    mov r7, #6              @ código de la llamada al sistema para cerrar
    swi 0                   @ llamada al sistema para cerrar el archivo de entrada

        @ Cerrar el archivo de salida
    mov r7, #6              @ código de la llamada al sistema para cerrar
    swi 0                   @ llamada al sistema para cerrar el archivo de salida

        @ Terminar la ejecución del programa
    mov r7, #0x1            @ código de la llamada al sistema para salir
    mov r0, #0              @ código de salida
    swi 0                   @ llamada al sistema para salir


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

add_reverberation:
    mov r6, #0               @ Inicializar el índice del buffer circular

    @ Calcular la dirección de inicio del buffer de salida
    ldr r7, =buffer_output   @ Dirección del buffer de salida

    @ Calcular el número de iteraciones necesarias (1608192 / 4 = 402048)
    ldr r8, =1608192
    mov r8, r8, lsr #2

add_reverb_loop:
    @ Calcular el índice circular en el buffer de salida
    cmp r6, #4                 @ Comprobar si el índice supera el tamaño del buffer
    movge r6, #0               @ Reiniciar el índice si supera el tamaño del buffer

    @ Calcular la muestra de salida y[n] = (1 - alpha) * x[n] + alpha * y[n - k]
    ldr r0, =buffer_input        @ Dirección del buffer de entrada
    add r0, r0, r5, lsl #2       @ Calcular la dirección de la muestra x[n]
    ldr r1, [r0]                 @ Cargar la muestra x[n]
    ldr r2, =buffer_output       @ Dirección del buffer de salida
    add r2, r2, r6, lsl #2       @ Calcular la dirección de la muestra y[n - k]
    ldr r2, [r2]                 @ Cargar la muestra y[n - k]
    sub r2, #1                   @ Calcular (1 - alpha) * y[n - k]
    mul r2, r2, r4               @ Calcular alpha * y[n - k]
    add r1, r1, r2               @ Calcular y[n] = (1 - alpha) * x[n] + alpha * y[n - k]

    @ Almacenar la muestra de salida en buffer_output
    str r1, [r7, r6, lsl #2]     @ Almacenar y[n] en la posición correspondiente del buffer de salida

    @ Incrementar el índice de buffer de salida
    add r7, r7, #4

    @ Incrementar el índice del buffer circular
    add r6, r6, #1               @ Incrementar el índice del buffer
    add r5, r5, #1               @ Incrementar el contador i
    cmp r5, r8                   @ Comprobar si se ha completado la iteración
    bne add_reverb_loop          @ Volver al bucle si no se ha completado

    bx lr                         @ Retornar

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

reduce_reverberation:
    mov r6, #0               @ Inicializar el índice del buffer circular

    @ Calcular la dirección de inicio del buffer de salida
    ldr r7, =buffer_output   @ Dirección del buffer de salida

    @ Calcular el número de iteraciones necesarias (1608192 / 4 = 402048)
    ldr r8, =1608192
    mov r8, r8, lsr #2
    
reduce_reverb_loop:
    cmp r6, #4                   @ Comprobar si el índice supera el tamaño del buffer
    movge r6, #0                 @ Reiniciar el índice si supera el tamaño del buffer

    @ Calcular la muestra de salida y(n) = [x(n) - alpha * x(n - k)] / (1 - alpha)
    ldr r0, =buffer_input        @ Dirección del buffer de entrada
    add r0, r0, r5, lsl #2       @ Calcular la dirección de la muestra x(n)
    ldr r1, [r0]                 @ Cargar la muestra x(n)
    ldr r2, =buffer_output       @ Dirección del buffer de salida
    add r2, r2, r6, lsl #2       @ Calcular la dirección de la muestra x(n - k)
    ldr r2, [r2]                 @ Cargar la muestra x(n - k)
    
    @ Calcular x(n) - alpha * x(n - k)
    ldr r4, =alpha               @ Cargar el valor de alpha
    mul r4, r4, r2               @ Calcular alpha * x(n - k)
    sub r3, r1, r4               @ Calcular x(n) - alpha * x(n - k)

    @ Calcular el factor de escala 1 / (1 - alpha)
    ldr r4, =#1                  @ Cargar el valor 1
    ldr r5, =#alpha              @ Cargar el valor de alpha
    sub r5, #1                   @ Calcular 1 - alpha
    udiv r6, r4, r5              @ Calcular 1 / (1 - alpha)

    @ Multiplicar el resultado por el factor de escala
    mul r3, r3, r6               @ Calcular (1 / (1 - alpha)) * [x(n) - alpha * x(n - k)]

    @ Almacenar la muestra de salida en buffer_output
    ldr r0, =buffer_output       @ Dirección del buffer de salida
    add r0, r0, r6, lsl #2       @ Calcular la dirección para almacenar y(n)
    str r3, [r0]                 @ Almacenar y(n)

    bx lr                         @ Retornar
