# Nombre del archivo de salida
OUTPUT = read_file

# Ensamblador ARM
#AS = arm-linux-gnueabi-as
AS = arm-linux-gnueabi-as -mcpu=cortex-a9

# Compilador de C para ARM
#CC = arm-linux-gnueabi-gcc-9
CC = arm-linux-gnueabi-ld

# Emulador QEMU para ARM
QEMU = qemu-arm

# Opciones de ensamblador y compilador
ASFLAGS = 
CFLAGS = -nostdlib

# Objetivo predeterminado
all: $(OUTPUT)

# Regla de compilación para el ensamblador
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Regla de compilación para el compilador de C
%.elf: %.o
	$(CC) $(CFLAGS) -o $@ $<

# Regla para ensamblar y enlazar el archivo fuente
$(OUTPUT): read_file.o
	$(CC) $(CFLAGS) -o $@ $<

# Regla para ejecutar el archivo en el emulador
run: $(OUTPUT).elf
	$(QEMU) ./$<

# Regla para limpiar los archivos generados
clean:
	rm -f $(OUTPUT) read_file.o

# Regla phony para evitar conflictos con archivos llamados clean o run
.PHONY: clean run

