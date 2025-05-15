init: clean
    git clone https://github.com/limine-bootloader/limine.git --branch=v9.x-binary --depth=1
    make -C limine

build:
    cd kernel && cargo build --profile dev # maybe change this

# Only uses bios for simplification
mkiso: build
    rm -rf iso_root
    mkdir -p iso_root/boot
    #                   Also uses debug here ||| And project name |||
    cp -v kernel/target/x86_64-unknown-none/debug/limine-rust-template iso_root/boot/kernel
    mkdir -p iso_root/boot/limine
    cp -v limine.conf iso_root/boot/limine/
    cp -v limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin iso_root/boot/limine/
    mkdir -p iso_root/EFI/BOOT
    cp -v limine/BOOTX64.EFI iso_root/EFI/BOOT/
    cp -v limine/BOOTIA32.EFI iso_root/EFI/BOOT/
    xorriso -as mkisofs -b boot/limine/limine-bios-cd.bin \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        --efi-boot boot/limine/limine-uefi-cd.bin \
        -efi-boot-part --efi-boot-image --protective-msdos-label \
        iso_root -o img.iso
    ./limine/limine bios-install img.iso
    rm -rf iso_root

run: mkiso
    qemu-system-x86_64 -drive format=raw,file=img.iso

clean:
    rm -rf limine
    rm -f img.iso
