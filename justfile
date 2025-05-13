_default:
  @just --choose

assemble-bootloader:
  cd bootloader && nasm boot.asm -f bin -o boot.bin

run:
  qemu-system-x86_64 -drive file=bootloader/boot.bin,format=raw,index=0,media=disk
