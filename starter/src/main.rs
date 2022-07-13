use methods::{MULTIPLY_ID, MULTIPLY_PATH};
use risc0_zkvm_host::Prover;
use risc0_zkvm_serde::{from_slice, to_vec};

use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;

fn main() {
    // Pick two numbers
    // let a: u64 = 17;
    // let b: u64 = 23;
    let file = File::open("theory/matching-logic-propositional-one-file.mm".clone())
        .expect("Failed to find file");

    let file_lines: Vec<String> = BufReader::new(file)
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();

    // Multiply them inside the ZKP
    // First, we make the prover, loading the 'multiply' method
    let mut prover = Prover::new(&std::fs::read(MULTIPLY_PATH).unwrap(), MULTIPLY_ID).unwrap();
    // Next we send a & b to the guest
    prover
        .add_input(to_vec(&file_lines).unwrap().as_slice())
        .unwrap();
    // prover.add_input(to_vec(&b).unwrap().as_slice()).unwrap();
    // Run prover & generate receipt
    let receipt = prover.run().unwrap();

    // Extract journal of receipt (i.e. output c, where c = a * b)
    let out: bool = from_slice(&receipt.get_journal_vec().unwrap()).unwrap();

    // Print an assertion
    println!(
        "The output of the metamath verifier is {}, and I can prove it!",
        out
    );

    // Here is where one would send 'receipt' over the network...

    // Verify receipt, panic if it's wrong
    receipt.verify(MULTIPLY_ID).unwrap();
}
