# Makefile para el Kernel en C

CC = gcc
CFLAGS = -m32 -ffreestanding -fno-pie -fno-stack-protector -nostdlib
LD = ld
LDFLAGS = -m elf_i386 -T linker.ld --oformat binary

all: os_image.bin

# Unimos el Bootloader y el Kernel
os_image.bin: boot.bin kernel.bin
	cat boot.bin kernel.bin > os_image.bin
	truncate -s 8192 os_image.bin

# Compilamos el Kernel
kernel.bin: kernel_entry.o kernel.o
	$(LD) $(LDFLAGS) -o $@ $^

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm -f elf32 $< -o $@

# El Bootloader (copiado de la fase 4 pero con carga de kernel)
boot.bin: boot.asm
	nasm -f bin $< -o $@

run: os_image.bin
	qemu-system-x86_64 os_image.bin

clean:
	rm -f *.o *.bin
