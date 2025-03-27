_default:
  @just --choose

build:
  @cargo build && cargo bootimage

run:
  @just build && qemu-system-x86_64 -drive format=raw,file=target/x86_64-foo_os/debug/bootimage-foo_os.bin
