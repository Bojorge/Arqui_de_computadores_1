nombre_archivo = 'ROM.mif'
linea_objetivo = 25
lineas = []

instrucciones_negativo = ["E3A00000",
                          "E3A01005",
                          "E3A020FF",
                          "E5D03000",
                          "E1F03000",
                          "E0413002",
                          "E5D03001",
                          "E2411001",
                          "1AFFFFFA",
                          "12000000"]

instrucciones_mediana = ["E59F0000",
                         "E3A01000",
                         "E3A02000",
                         "E3A03000",
                         "E1A04003",
                         "E3A05000",
                         "E1A06003",
                         "E5D07000",
                         "E0855007",
                         "E1A06001",
                         "E2411001",
                         "1AFFFFF8",
                         "E3520001",
                         "0A000002",
                         "E2800001",
                         "E2840401",
                         "EAFFFFEE",
                         "E3A08000",
                         "EE075A90",
                         "E5D05000",
                         "E2800001",
                         "E2833001",
                         "E35300FF",
                         "1AFFFFCE",
                         "12000000"]

with open(nombre_archivo, 'r') as archivo:
        lineas = archivo.readlines()[0:24]
        
count = 0
longitud = len(instrucciones_negativo)
if 1 <= linea_objetivo <= len(lineas) + 1:
    for i in range(longitud):
        linea = f'\t{count} : {instrucciones_negativo[i]};\n\t[{count+1}..{count+3}] : 0;\n'
        lineas.insert(linea_objetivo + count - 1, linea)
        count += 4
    lineas.insert(linea_objetivo + count, f'\t[{count}..{255}] : 0;\n')
    lineas.insert(linea_objetivo + count + 1, "END;")

with open(nombre_archivo, 'w') as archivo:
    archivo.writelines(lineas)

print(f'Los valores de instrucciones se han guardado en {nombre_archivo}')
