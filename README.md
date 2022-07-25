# RISC Zero Metamath Checker

This repository, based on [`risc0-rust-starter`](https://github.com/risc0/risc0-rust-starter) and [`rust-metamath`](https://github.com/jzw2/rust-metamath), is a ZK-STARKed Metamath checker. It uses [RISC Zero](https://www.risczero.com/) to compile a checker for the [Metamath formal language](https://us.metamath.org/) to a RISC-V based zkVM.

The prover provides a Metamath file and specifies a theorem name to the guest. The guest then returns a receipt which includes the hash of that theorem's statement, a list of hashes of axioms used by the file, and a zero-knowledge proof that that theorem can indeed be proved from the axioms.

## Quick Start

First, make sure [rustup](https://rustup.rs) is installed. This project uses a [nightly](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html) version of [Rust](https://doc.rust-lang.org/book/ch01-01-installation.html), `rustup` will automatically install the correct version.

To build all methods and execute the method within the zkVM, run the following command:

```
cargo run --release
```

## Zero-Knowledge Programs

A zkVM program is composed of a `host` and a `guest`. The [host](starter/src/main.rs) code runs like any other rust program and launches a zkVM instance using the [Prover](https://docs.rs/risc0-zkvm-host/0.10.0/risc0_zkvm_host/struct.Prover.html) interface. The [guest](methods/guest/src/bin/multiply.rs) code is compiled for `riscv32im` and runs inside a zkVM. Guest code does not have access to `std` since the zkVM is similar to an embedded system. Use the [env](https://docs.rs/risc0-zkvm-guest/0.10.0/risc0_zkvm_guest/env/index.html) in your zkVM guest code to communicate with the host.

## Contributor's Guide
We welcome contributions to documentation and code via [PRs and GitHub Issues](http://www.github.com/risc0).

## Questions, Feedback, and Collaborations
We'd love to hear from you on [Discord](https://discord.gg/risczero) or [Twitter](https://twitter.com/risczero).
