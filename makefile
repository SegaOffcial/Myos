CC=x86_64-elf-gcc
LD=x86_64-elf-ld
AS=nasm

all: os-image

boot/boot.bin: boot/boot.s
	$(AS) -f bin boot/boot.s -o boot/boot.bin

kernel/kernel.o: kernel/kernel.c
	$(CC) -ffreestanding -c kernel/kernel.c -o kernel/kernel.o

kernel/kernel.bin: kernel/kernel.o linker.ld
	$(LD) -T linker.ld kernel/kernel.o -o kernel/kernel.bin

os-image: boot/boot.bin kernel/kernel.bin
	cat boot/boot.bin kernel/kernel.bin > os-image

run: os-image
	qemu-system-x86_64 -drive format=raw,file=os-image

clean:
	rm -f boot/boot.bin kernel/kernel.o kernel/kernel.bin os-image
