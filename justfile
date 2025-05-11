_default:
  @just --choose

assemble-bootloader:
  nasm src/boot.asm -f bin -o boot.bin

run:
  qemu-system-x86_64 -fda boot.bin
