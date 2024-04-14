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
    @ Abrir el archivo de entrada
    mov r7, #0x5                                        @ código de la llamada al sistema para abrir
    ldr r0, =name_input                                 @ nombre del archivo de entrada
    mov r1, #2                                          @ configuración para abrir (O_RDONLY)
    mov r2, #0                                          @ modo predeterminado
    swi 0                                               @ llamada al sistema para abrir el archivo de entrada

    @ Leer desde el archivo de entrada al buffer de entrada
    mov r7, #0x3                                        @ código para la llamada al sistema read
    ldr r1, =buffer_input                               @ dirección del buffer de entrada
    ldr r2, =#1608192                                   @ tamaño del buffer de entrada
    swi 0                                               @ llamada al sistema para leer
    
    @ Normalizar la data
    bl normalize_data

    @ Cerrar el archivo de entrada
    mov r7, #6                                          @ código de la llamada al sistema para cerrar
    swi 0                                               @ llamada al sistema para cerrar el archivo de entrada

    @ Aplicar la reverberación a las muestras de entrada
    bl add_reverberation
    bl reduce_reverberation

        @ Terminar la ejecución del programa
    mov r7, #0x1                                        @ código de la llamada al sistema para salir
    mov r0, #0                                          @ código de salida
    swi 0                                               @ llamada al sistema para salir


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Normalizar@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
normalize_data:
    ldr r5, =#2147483647         @ Cargar el valor máximo permitido para una muestra de 32 bits (2^31 - 1)
    mov r6, #0                    @ Inicializar el contador de muestras

normalize_loop:
    cmp r6, r8                    @ Comprobar si se ha alcanzado el final de los datos
    beq normalize_done            @ Si todas las muestras han sido normalizadas, salir del bucle

    ldr r0, [r1, r6]              @ Cargar una muestra de 32 bits del buffer de entrada
    cmp r0, #0                    @ Comprobar si la muestra es negativa
    blt normalize_negative        @ Si la muestra es negativa, saltar a la etiqueta correspondiente

    cmp r0, r5                    @ Comprobar si la muestra excede el valor máximo permitido
    bgt normalize_positive        @ Si la muestra es mayor que el valor máximo permitido, saltar a la etiqueta correspondiente

    b normalize_continue          @ Continuar con la siguiente muestra

normalize_negative:
    mov r0, #-2147483647         @ Establecer la muestra en el valor mínimo permitido si es negativa
    b normalize_continue

normalize_positive:
    mov r0, r5                    @ Establecer la muestra en el valor máximo permitido si es mayor que eso
    b normalize_continue

normalize_continue:
    sdiv r0, r0, r5               @ Normalizar la muestra dividiéndola por el valor máximo positivo
    str r0, [r1, r6]              @ Almacenar la muestra normalizada en el mismo lugar del buffer de entrada
    add r6, r6, #4                @ Incrementar el contador de muestras en 4 bytes (tamaño de una muestra de 32 bits)
    b normalize_loop              @ Volver al inicio del bucle

normalize_done:
    bx lr                         @ Retornar

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@@@@@@@@@@@@@@@@@@@@ AGREGAR REVERBERIZADO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

add_reverberation:
    ldr r3, =#k                                         @ Cargar el valor de k
    mov r5, #0                                          @ Inicializar n
    mov r6, #0                                          @ Inicializar el índice del buffer circular
    
    ldr r7, =buffer_output                              @ Dirección del buffer de salida

    @ Calcular el número de iteraciones necesarias (1608192 / 4 = 402048)
    ldr r8, =1608192
    mov r8, r8, lsr #2

add_reverb_loop:
    @ Calcular el índice circular en el buffer de salida
    cmp r6, #4                                          @ Comprobar si el índice supera el tamaño del buffer
    movge r6, #0                                        @ Reiniciar el índice si supera el tamaño del buffer

    
    ldr r4, =#alpha                                     @ Cargar el valor de alpha
    
    @ Calcular la muestra de salida y[n] = (1 - alpha) * x[n] + alpha * y[n - k]
    ldr r0, =buffer_input                               @ *** Dirección del buffer de entrada
    add r0, r0, r5, lsl #2                              @ Calcular la dirección de la muestra x[n]
    ldr r1, [r0]                                        @ *** Cargar la muestra x[n]
    ldr r2, =buffer_output                              @ *** Dirección del buffer de salida

    cmp r5, r3                                          @ Comparar n=r5 con k=r3
    blt n_minus_k_is_negative_rev                       @ Si n < k entonces y[n - k] = 0
    bge load_y_n_minus_k_rev                            @ Si n >= k entonces se calcula y carga y[n - k]

    n_minus_k_is_negative_rev:
        mov r2, #0                                      @ Cargar en r2 el valor de y(n - k) = 0 
        b continue_rev

    load_y_n_minus_k_rev:
        sub r3, r5, r3                                  @ Calcular n - k
        lsl r3, r3, #2                                  @ Calcular el desplazamiento multiplicando por el tamaño de una palabra (4 bytes)
        add r2, r2, r3                                  @ Calcular la dirección de la muestra y[n - k]
        b continue_rev

    continue_rev:

    @@ @@ @@ @@ @@ @@ ECUACION DE DIFERENCIAS (AGREGAR REVERBERACION) @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ 

    @ Calcular y[n] = ((1 - alpha) * x[n]) + (alpha * y[n - k])
    mul r9, r4, r2                                      @ Calcular alpha * y[n - k]
    rsb r4, r4, #1                                      @ Calcular (1 - alpha)
    mul r10, r4, r1                                     @ Calcular (1 - alpha) * x[n]
    add r1, r9, r1                                      @ Calcular ((1 - alpha) * x[n]) + (alpha * y[n - k])
    
    @ Almacenar la muestra de salida en buffer_output
    str r1, [r7, r6, lsl #2]     @ Almacenar y[n] en la posición correspondiente del buffer de salida
    
    @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ 

    @ Incrementar el índice de buffer de salida
    add r7, r7, #4

    add r6, r6, #1                                      @ Incrementar el índice del buffer circular
    add r5, r5, #1                                      @ Incrementar n
    cmp r5, r8                                          @ Comprobar si se ha completado la iteración
    bne add_reverb_loop                                 @ Volver al bucle si no se ha completado

    @ Abrir el archivo de salida resultado reverberizado
    mov r7, #0x5            			                @ código de la llamada al sistema para abrir
    ldr r0, =name_output_add_reverberizacion            @ nombre del archivo de salida
    mov r1, #66            		                        @ configuración para abrir (O_WRONLY|O_CREAT|O_TRUNC)
    mov r2, #438           		                        @ permisos para el archivo de salida (0666 en octal)
    swi 0                   		                    @ llamada al sistema para abrir el archivo de salida

    @ Escribir desde el buffer de salida al archivo de salida
    mov r7, #0x4            	                        @ código para la llamada al sistema write
    ldr r1, =buffer_output   	                        @ dirección del buffer de salida
    ldr r2, =1608192          	                        @ tamaño del buffer de entrada
    swi 0                   	                        @ llamada al sistema para escribir en el archivo de salida
    
        @ Cerrar el archivo de salida
    mov r7, #6                                          @ código de la llamada al sistema para cerrar
    swi 0   

    bx lr                                               @ Retornar


@@@@@@@@@@@@@@@@@@@@ REDUCIR REVERBERIZADO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


reduce_reverberation:
    ldr r3, =#k                                         @ Cargar el valor de k
    mov r5, #0                                          @ Inicializar n
    mov r6, #0                                          @ Inicializar el índice del buffer circular

    ldr r7, =buffer_output                              @ Dirección del buffer de salida

    @ Calcular el número de iteraciones necesarias (1608192 / 4 = 402048)
    ldr r8, =1608192
    mov r8, r8, lsr #2
    
reduce_reverb_loop:
    @ Calcular el índice circular en el buffer de salida
    cmp r6, #4                                          @ Comprobar si el índice supera el tamaño del buffer
    movge r6, #0                                        @ Reiniciar el índice si supera el tamaño del buffer  

    ldr r4, =#alpha                                     @ Cargar el valor de alpha
    
    @ Calcular la muestra de salida y(n) = [1 / (1 - alpha)] * [x(n) - alpha * x(n - k)]
    ldr r0, =buffer_input                               @ *** Dirección del buffer de entrada
    add r0, r0, r5, lsl #2                              @ Calcular la dirección de la muestra x[n]
    ldr r1, [r0]                                        @ *** Cargar la muestra x[n]
    ldr r2, =buffer_output                              @ *** Dirección del buffer de salida
    ldr r0, =buffer_input                               @ La dirección del buffer de entrada se carga de nuevo porque se sobreescribió r0
    
    cmp r5, r3                                          @ Comparar n=r5 con k=r3
    blt n_minus_k_is_negative_sin_rev                   @ Si n < k entonces x[n - k] = 0
    bge load_x_n_minus_k_sin_rev                        @ Si n >= k entonces se carga x[n - k]

    n_minus_k_is_negative_sin_rev:
        mov r2, #0                                      @ Cargar en r2 el valor de x(n - k) = 0 
        b continue_sin_rev

    load_x_n_minus_k_sin_rev:  
        sub r3, r5, r3                                  @ Calcular n - k
        lsl r3, r3, #2                                  @ Calcular el desplazamiento multiplicando por el tamaño de una palabra (4 bytes)
        add r2, r0, r3                                  @ Calcular la dirección de la muestra x[n - k]
        b continue_sin_rev

    continue_sin_rev:

    @@ @@ @@ @@ @@ @@ ECUACION DE DIFERENCIAS (QUITAR REVERBERACION) @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ 

    @ Calcular x[n] - alpha * x[n - k]
    mul r4, r4, r2                                      @ Calcular alpha * x[n - k]
    sub r3, r1, r4                                      @ Calcular x(n) - alpha * x[n - k]

    @ Calcular el factor de escala 1 / (1 - alpha)
    rsb r4, r4, #1                                      @ Calcular 1 - alpha
    ldr r10, =#1                                        @ Cargar el valor 1
    udiv r9, r10, r4                                    @ Calcular 1 / (1 - alpha)

    @ Calcular (1 / (1 - alpha)) * [x(n) - alpha * x(n - k)] = y(n)
    mul r1, r3, r9          
    
    @ Almacenar la muestra de salida en buffer_output
    str r1, [r7, r6, lsl #2]                            @ Almacenar y[n] en la posición correspondiente del buffer de salida

    @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ 

    @ Incrementar el índice de buffer de salida
    add r7, r7, #4

    add r6, r6, #1                                      @ Incrementar el índice del buffer circular
    add r5, r5, #1                                      @ Incrementar n
    cmp r5, r8                                          @ Comprobar si se ha completado la iteración

    bne reduce_reverb_loop                              @ Volver al bucle si no se ha completado

    @ Abrir el archivo de salida resultado sin reverberizado
    mov r7, #0x5            			                @ código de la llamada al sistema para abrir
    ldr r0, =name_output_reduce_reverberizacion         @ nombre del archivo de salida
    mov r1, #66            		                        @ configuración para abrir (O_WRONLY|O_CREAT|O_TRUNC)
    mov r2, #438           		                        @ permisos para el archivo de salida (0666 en octal)
    swi 0                   		                    @ llamada al sistema para abrir el archivo de salida

    @ Escribir desde el buffer de entrada al archivo de salida
    mov r7, #0x4            	                        @ código para la llamada al sistema write
    ldr r1, =buffer_output   	                        @ dirección del buffer de salida
    ldr r2, =1608192          	                        @ tamaño del buffer de entrada
    swi 0                   	                        @ llamada al sistema para escribir en el archivo de salida

        @ Cerrar el archivo de salida
    mov r7, #6                                          @ código de la llamada al sistema para cerrar
    swi 0                                               @ llamada al sistema para cerrar el archivo de salida

    bx lr                                               @ Retornar
