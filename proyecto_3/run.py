import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import re

plt.switch_backend('Agg')

# Lista global para almacenar los valores de cada métrica
metric_values = {
    'simInsts': [], 'system.cpu.cpi': [], 'system.cpu.ipc': [], 'system.cpu.numCycles': [],
    'system.cpu.branchPred.lookups': [], 'system.l2.overallMissRate::total': [], 'system.l2.demandAccesses::total': [],
    'simTicks': [], 'system.cpu.numCycles': [], 'simFreq': [], 'system.cpu.branchPred.BTBHits': [],
    'system.cpu.branchPred.indirectMisses': [], 'system.cpu.branchPred.indirectHits': [],
    'hostInstRate': [], 'hostOpRate': []
}

def read_and_parse_file(file_path):
    """Lee y analiza el contenido de un archivo."""
    stats = {}
    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('#') or line.strip() == '' or line.startswith('Begin') or line.startswith('End'):
                continue
            key_value = line.strip().split()
            key = key_value[0]
            value = key_value[1] if len(key_value) > 1 else None
            if value is not None and value != "End" and value != "Begin":
                try:
                    stats[key] = float(value)
                    if key in metric_values:
                        metric_values[key].append(float(value))
                    else:
                        # Verificar si hay claves que coincidan parcialmente
                        for metric_name in metric_values.keys():
                            if metric_name in key:
                                metric_values[metric_name].append(float(value))
                                break
                except ValueError:
                    print(f"Error: no se pudo convertir '{value}' en un número flotante en la línea: {line}")
    return stats

def process_folder(folder_path):
    """Procesa todos los archivos stats.txt en la carpeta dada."""
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.startswith('m5out_') and file.endswith('.txt'):
                file_path = os.path.join(root, file)
                stats = read_and_parse_file(file_path)

def save_bar_plot(x, y, title, xlabel, ylabel, file_name):
    """Guarda el gráfico de barras como un archivo de imagen."""
    plt.figure()
    bars = plt.bar(x, y)  # Usar el nombre del archivo como etiqueta en el eje x
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)

    # Reemplazar '::' con '_'
    file_name = file_name.replace("::", "_")
    
    plt.savefig(file_name)
    plt.close()


def calculate_standard_deviation(values):
    return np.std(values) if len(values) > 1 else 0

def calculate_percentage_error(values):
    if len(values) == 0:
        return [0]
    mean_value = np.mean(values)
    return [(abs(value - mean_value) / mean_value) * 100 for value in values] if mean_value != 0 else [0 for _ in values]

def calculate_variability(values):
    return np.var(values) if len(values) > 1 else 0

def plot_and_save_metrics(metric_name, values, output_folder):
    """Traza y guarda métricas específicas para cada variación de parámetros."""
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    iterations = range(len(values))

    # Verificar si la lista de valores no está vacía antes de intentar trazar el gráfico
    if len(values) > 0:
        # Plot and save the actual metric values
        save_bar_plot(iterations, values, f'{metric_name} vs Iteración', 'Iteración', metric_name, 
                      os.path.join(output_folder, f'{metric_name}_values.png'))

def plot_overlapping_metrics(metrics_dict, metric_function, metric_name, output_folder, ylabel):
    """Traza y guarda gráficos superpuestos para todas las métricas con respecto a una métrica específica."""
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    plt.figure()
    bar_width = 0.25
    for idx, (metric, values) in enumerate(metrics_dict.items()):
        if values:
            metric_values = [metric_function(values)] * len(values)
            positions = np.arange(len(values)) + idx * bar_width
            bars = plt.bar(positions, metric_values, width=bar_width, label=metric)
            
            # Añadir valores encima de las barras
            for bar in bars:
                yval = bar.get_height()
                plt.text(bar.get_x() + bar.get_width()/2.0, yval, f'{yval:.2f}', va='bottom', fontsize=8)

    plt.title(f'{metric_name} de Todas las Métricas')
    plt.xlabel('Iteración')
    plt.ylabel(ylabel)
    plt.legend(fontsize=8, loc='upper left', bbox_to_anchor=(1, 1))
    plt.tight_layout()
    plt.savefig(os.path.join(output_folder, f'{metric_name}_overlapping.png'))
    plt.close()

def main():
    base_folder = r'C:\Users\josep\OneDrive\Documents\Analisis\stats'
    process_folder(base_folder)

    # Imprimir todas las listas al finalizar
    for metric_name, values in metric_values.items():
        print(f'{metric_name}: {values}')
        plot_and_save_metrics(metric_name, values, os.path.join(base_folder, 'plots'))
    
    # Graficar y guardar métricas superpuestas
    plot_overlapping_metrics(metric_values, calculate_standard_deviation, 'Desviación Estándar', 
                             os.path.join(base_folder, 'plots'), 'Desviación Estándar')
    plot_overlapping_metrics(metric_values, calculate_variability, 'Variabilidad', 
                             os.path.join(base_folder, 'plots'), 'Variabilidad')
    plot_overlapping_metrics(metric_values, lambda x: np.mean(calculate_percentage_error(x)), 'Error Porcentual', 
                             os.path.join(base_folder, 'plots'), 'Error Porcentual (%)')

if __name__ == "__main__":
    main()
