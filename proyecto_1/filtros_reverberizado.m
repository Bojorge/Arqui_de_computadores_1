clear
clc% Definir los parámetros
alpha = single(0.6);
k = 2205;

% Leer muestras de entrada desde el archivo
fid = fopen('samples.bin', 'r');
buffer_input = fread(fid, 'float32');
fclose(fid);

% Inicializar el buffer de salida para el filtro reverberizado
buffer_output_reverberizado = zeros(size(buffer_input), 'single');

% Aplicar filtro reverberizado
for n = 1:length(buffer_input)
    if n - k > 0
        y_n_k = buffer_output_reverberizado(n - k);
    else
        y_n_k = 0;
    end
    buffer_output_reverberizado(n) = (1 - alpha) * buffer_input(n) + alpha * y_n_k;
end

% Escribir los resultados en el archivo de salida
fid = fopen('output_reverberizado.bin', 'w');
fwrite(fid, buffer_output_reverberizado, 'float32');
fclose(fid);


% Inicializar el buffer de salida para la ecuación adicional
buffer_output_sin_reverberizado = zeros(size(buffer_input), 'single');

% Aplicar la ecuación adicional
for n = 1:length(buffer_input)
    if n - k > 0
        x_n_k = buffer_input(n - k);
    else
        x_n_k = 0;
    end
    buffer_output_sin_reverberizado(n) = (buffer_input(n) - (alpha * x_n_k)) / ((1 - alpha)*10);
end

% Escribir los resultados en el archivo de salida
fid = fopen('output_sin_reverberizado.bin', 'w');
fwrite(fid, buffer_output_sin_reverberizado, 'float32');
fclose(fid);
