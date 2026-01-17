# Configuración del Toolchain
AS = riscv64-linux-gnu-as
LD = riscv64-linux-gnu-ld
QEMU = qemu-system-riscv64

# Opciones
ASFLAGS = -g
LDFLAGS = -T link.ld
QEMUFLAGS = -machine virt -nographic -bios none

# Archivos
SRC = kernel.s
OBJ = kernel.o
ELF = kernel.elf

# Regla por defecto: compilar todo
all: $(ELF)

$(OBJ): $(SRC)
	$(AS) $(ASFLAGS) -o $(OBJ) $(SRC)

$(ELF): $(OBJ)
	$(LD) $(LDFLAGS) -o $(ELF) $(OBJ)

# Regla para ejecutar directamente
run: $(ELF)
	$(QEMU) $(QEMUFLAGS) -kernel $(ELF)

# Regla para depurar con GDB (congelado al inicio)
debug: $(ELF)
	$(QEMU) $(QEMUFLAGS) -kernel $(ELF) -S -s

# Limpiar archivos generados
clean:
	rm -f $(OBJ) $(ELF)