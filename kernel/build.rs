fn main() {
    println!("cargo:rerun-if-changed=build.rs");
    // Tell cargo to pass the linker script to the linker..
    println!("cargo:rustc-link-arg=-Tlinker-x86_64.ld");
    // ..and to re-run if it changes.
    println!("cargo:rerun-if-changed=linker-x86_64.ld");
}
