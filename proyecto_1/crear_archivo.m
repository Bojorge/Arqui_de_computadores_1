clear
clc

% Cargar el archivo de audio WAV
[archivo, fs] = audioread('prueba_audio.wav');

% Extraer el nombre del archivo sin la extensión
nombre_archivo = 'samples.bin';

% Guardar las muestras en un archivo binario
fid = fopen(nombre_archivo, 'wb');
fwrite(fid, archivo, 'float32');  % Guardar en formato binario de 32 bits de punto flotante
fclose(fid);
disp(['Se han guardado las muestras del archivo de audio en el archivo ', nombre_archivo]);