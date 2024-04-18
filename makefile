# Van Pratt González Ricardo Adolfo
# 21212581
# Lenguajes de Interfaz 6to semestre

# Hanoi, usa hanoi.s

# Nombre del archivo del programa
TARGET = hanoi2

# Assembler y linker
AS = as
CC = gcc

# Opciones de ensamblaje y enlace
ASFLAGS = -g
LDFLAGS = -g

# Reglas de construcción
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(LDFLAGS) $^ -o $@

$(TARGET).o: $(TARGET).s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(TARGET) $(TARGET).o

.PHONY: all clean
