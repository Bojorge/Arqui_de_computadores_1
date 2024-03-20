clear
clc

% Nombre del archivo binario que contiene las muestras de audio
nombre_archivo = 'output_sin_reverberizado.bin';

% Abrir el archivo binario para lectura
fid = fopen(nombre_archivo, 'rb');

% Leer las muestras del archivo binario
muestras_audio = fread(fid, Inf, 'float32');

% Cerrar el archivo
fclose(fid);

% Obtener la frecuencia de muestreo del audio
fs = 44100/2;  %frecuencia de muestreo 44100 Hz

% Reproducir el audio
sound(muestras_audio, fs);


