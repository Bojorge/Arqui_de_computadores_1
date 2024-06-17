import os

def read_and_print_metrics(file_path, seen_metrics):
    """Lee y muestra los nombres de las métricas de un archivo."""
    print(f"Leyendo el archivo: {file_path}")
    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('#') or line.strip() == '' or line.startswith('Begin') or line.startswith('End'):
                continue
            key_value = line.strip().split()
            key = key_value[0]
            if key not in seen_metrics:
                seen_metrics.add(key)
                print(key)

def main():
    base_folder = r'C:\Users\josep\OneDrive\Documents\Analisis\stats'
    seen_metrics = set()
    for root, dirs, files in os.walk(base_folder):
        for file_name in files:
            if file_name.endswith('.txt'):
                file_path = os.path.join(root, file_name)
                print(f"Archivo: {file_path}")
                read_and_print_metrics(file_path, seen_metrics)
                return  # Salir después de leer el primer archivo

if __name__ == "__main__":
    main()
