use methods::{MULTIPLY_ID, MULTIPLY_PATH};
use risc0_zkp::core::sha::Digest;
use risc0_zkvm::host::Prover;
use risc0_zkvm::serde::{from_slice, to_vec};

use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;

fn main() {

    let axiom_file = File::open("theory/simple.mm".clone()).expect("Failed to find file");

    let axiom_file_lines: Vec<String> = BufReader::new(axiom_file)
        .lines()
        .map(|l| l.expect("Could not parse line"))
        .collect();

    // let proof_file = File::open("theory/matching-logic-240-loc.mm".clone()).expect("Failed to find file");

    // let proof_file_lines: Vec<String> = BufReader::new(proof_file)
    //     .lines()
    //     .map(|l| l.expect("Could not parse line"))
    //     .collect();
        
    // Multiply them inside the ZKP
    // First, we make the prover, loading the 'multiply' method
    let mut prover = Prover::new(&std::fs::read(MULTIPLY_PATH).unwrap(), MULTIPLY_ID).unwrap();


    // Send target theorem to prover, the theorem name that the prover should guarantee the correctness of
    let target_theorem: String = "th1".to_string();
    prover
        .add_input(to_vec(&target_theorem).unwrap().as_slice())
        .unwrap();


    // prover
    //     .add_input(to_vec(&axiom_file_lines).unwrap().as_slice())
    //     .unwrap();


    // Next we send the file to the guest, one line at a time
    for line in axiom_file_lines {
        prover
            .add_input(to_vec(&Some(line)).unwrap().as_slice())
            .unwrap();
    }
    // Send a non value to signify the end of the file
    let eof: Option<String> = None;
    prover
        .add_input(to_vec(&eof).unwrap().as_slice())
        .unwrap();

    
    // prover
    //     .add_input(to_vec(&proof_file_lines).unwrap().as_slice())
    //     .unwrap();


    // prover.add_input(to_vec(&b).unwrap().as_slice()).unwrap();
    // Run prover & generate receipt
    let receipt = prover.run().unwrap();

    // Extract journal of receipt (i.e. output c, where c = a * b)
    let axioms: Vec<Digest> = from_slice(&receipt.get_journal_vec().unwrap()).unwrap();
    let theorem: Digest = from_slice(&receipt.get_journal_vec().unwrap()).unwrap();

    // Print an assertion
    println!(
        "The metamath verifier succeeds, and I can prove it! It outputs theorem hash {:?} using axioms {:?}",
        theorem, axioms
    );

    // Here is where one would send 'receipt' over the network...

    // Verify receipt, panic if it's wrong
    receipt.verify(MULTIPLY_ID).unwrap();
}
