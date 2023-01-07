nasm "boot.asm" -f bin -o "Binaries/boot.bin"
nasm "kernel_entry.asm" -f elf -o "Binaries/kernel_entry.o"
gcc -ffreestanding -m32 -g -c "kernel.cpp" -o "Binaries/kernel.o"
nasm "zeroes.asm" -f bin -o "Binaries/zeroes.bin"

ld -m elf_i386 -o "Binaries/full_kernel.bin" -Ttext 0x1000 "Binaries/kernel_entry.o" "Binaries/kernel.o" --oformat binary --entry main --ignore-unresolved-symbol _GLOBAL_OFFSET_TABLE_

cat "Binaries/boot.bin" "Binaries/full_kernel.bin" "Binaries/zeroes.bin" >"Binaries/OS.bin"

qemu-system-x86_64 -drive format=raw,file="Binaries/OS.bin",index=0,if=floppy, -m 128M
