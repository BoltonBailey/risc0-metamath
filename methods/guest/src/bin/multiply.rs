#![no_main]
#![no_std]

use risc0_zkvm_guest::env;

risc0_zkvm_guest::entry!(main);

extern crate alloc;

use crate::alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::collections::BTreeSet;
use alloc::collections::VecDeque;
use alloc::rc::Rc;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use core::cmp::max;
use core::cmp::min;
use core::ops::Deref;
// use std::fs::File;
// use std::io::BufRead;
// use std::io::BufReader;

#[derive(Debug)]
pub struct Tokens {
    lines_buffer: VecDeque<String>,
    token_buffer: Vec<String>,
    imported_files: BTreeSet<String>,
}

//since statement may be used multiple times when applying substitution
// use Rc
pub type Statement = Rc<[LanguageToken]>; //may be better to new type this but I guess it works for now

pub type Proof = Vec<Label>; //I don't think a proof is used multiple times
pub type Label = Rc<str>;
pub type LanguageToken = Rc<str>;

impl Tokens {
    pub fn new(lines: Vec<String>) -> Tokens {
        Tokens {
            lines_buffer: VecDeque::from(lines),
            token_buffer: vec![],
            imported_files: BTreeSet::new(),
        }
    }
    pub fn read(&mut self) -> Option<String> {
        // println!("inside read function with state {:?}", self);
        while self.token_buffer.is_empty() {
            //println!("Buffer is empty, refilling");
            // let mut line = String::new();
            // pretend this succeeds
            // let result = self.lines_buffer.last_mut().unwrap().read_line(&mut line);
            let result = self.lines_buffer.pop_front();
            // println!("Read line: {}", line);

            match result {
                Some(line) => {
                    // println!("Read {} lines ", num);
                    self.token_buffer = line.split_whitespace().map(|x| x.into()).collect();
                    self.token_buffer.reverse();
                }
                _ => {
                    // println!("Done with file");
                    self.lines_buffer.pop_front();
                    if self.lines_buffer.is_empty() {
                        return None;
                    }
                }
            }
            // println!("Created token buffer {:?}", self.token_buffer);
        }
        self.token_buffer.pop()
    }

    fn read_file(&mut self) -> Option<String> {
        // println!("reading file");

        let mut token = self.read();
        // println!("In read file found token {:?}", token);
        while let Some("$[") = token.as_deref() {
            let filename = self.read().expect("Couldn't find filename");
            let end_bracket = self.read().expect("Couldn't find end bracket");

            // println!("In read file found filename: {:?}, end_bracket: {:?}", filename, end_bracket);
            if end_bracket != "$]" {
                panic!("End bracket not found");
            }

            if !self.imported_files.contains(&filename) {
                // println!("Found new file {}", &filename);

                panic!("Doesn't currently support multiple files at once");
                // self.lines_buffer.push(BufReader::new(
                //     File::open(filename.clone()).expect("Failed to open file"),
                // ));
                // self.imported_files.insert(filename);
            }
            token = self.read();
        }
        token
    }

    pub fn read_comment(&mut self) -> Option<String> {
        // println!("reading comment");

        loop {
            let mut token = self.read_file();
            // println!("In read comment: found token to be {:?}", token);
            match &token {
                None => return None,
                Some(x) if x == "$(" => loop {
                    match token.as_deref() {
                        Some("$)") => break,
                        _ => token = self.read(),
                    }
                },
                _ => return token,
            }
        }
    }

    pub fn read_statement(&mut self) -> Statement {
        let mut stat: Vec<Rc<str>> = vec![];
        let mut token = self
            .read_comment()
            .expect("Failed to read token in read stat");

        // println!("In read stat, found token to be {:?}", token);
        while token != "$." {
            stat.push(token.into());
            token = self.read_comment().expect("EOF before $.");
        }
        stat.into()
    }
}

#[derive(Default, Debug)]
pub struct Frame {
    c: BTreeSet<LanguageToken>,
    v: BTreeSet<LanguageToken>,
    d: BTreeSet<(LanguageToken, LanguageToken)>, //maybe switch this give c and v different types
    f: Vec<(LanguageToken, LanguageToken)>,
    f_labels: BTreeMap<LanguageToken, Label>,
    e: Vec<Statement>,
    e_labels: BTreeMap<Statement, Label>,
}

#[derive(Default, Debug)]
pub struct FrameStack {
    pub list: Vec<Frame>,
}

#[derive(Debug)]
pub struct Assertion {
    pub dvs: BTreeSet<(LanguageToken, LanguageToken)>,
    pub f_hyps: VecDeque<(LanguageToken, LanguageToken)>,
    pub e_hyps: Vec<Statement>,
    pub stat: Statement,
}

impl Assertion {
    pub fn to_string(&self) -> String {
        let mut out = String::new();
        for lt in self.stat.deref() {
            out.push_str(lt.deref());
            out.push(' ');
        }
        out
    }
}

impl FrameStack {
    pub fn push(&mut self) {
        self.list.push(Frame::default());
    }

    pub fn add_c(&mut self, token: LanguageToken) {
        let frame = &mut self.list.last_mut().unwrap();

        if frame.c.contains(&token) {
            panic!("Const already defined")
        }
        if frame.v.contains(&token) {
            panic!("consta elaryd defined as var in scope")
        }
        frame.c.insert(token);
    }

    pub fn add_v(&mut self, token: LanguageToken) {
        let frame = &mut self.list.last_mut().unwrap();

        if frame.c.contains(&token) {
            panic!("Variable already defined")
        }
        if frame.v.contains(&token) {
            panic!("Variable elaryd defined as var in scope")
        }
        frame.v.insert(token);
    }

    pub fn add_f(&mut self, var: LanguageToken, kind: LanguageToken, label: Label) {
        if !self.lookup_v(&var) {
            panic!("var not defined")
        }
        if !self.lookup_c(&kind) {
            panic!("const not defined")
        }

        let frame = self.list.last_mut().unwrap();
        if frame.f_labels.contains_key(&var) {
            panic!("f already defined in scope")
        }
        frame.f.push((var.clone(), kind));
        frame.f_labels.insert(var, label);
    }

    pub fn add_e(&mut self, stat: Statement, label: Label) {
        let frame = self.list.last_mut().unwrap();

        frame.e.push(stat.clone());
        frame.e_labels.insert(stat, label);
    }

    pub fn add_d(&mut self, stat: Statement) {
        let frame = self.list.last_mut().unwrap();
        //let mut product_vec = vec!();
        for x in stat.iter() {
            for y in stat.iter() {
                if x != y {
                    frame
                        .d
                        .insert((min(x.clone(), y.clone()), max(x.clone(), y.clone())));
                }
            }
        }
    }

    pub fn lookup_c(&self, token: &str) -> bool {
        self.list.iter().rev().any(|fr| fr.c.contains(token))
    }

    pub fn lookup_v(&self, token: &str) -> bool {
        self.list.iter().rev().any(|fr| fr.v.contains(token))
    }

    pub fn lookup_f(&self, var: LanguageToken) -> Label {
        // println!("lookup {}", var);
        let f = self
            .list
            .iter()
            .rev()
            .find(|frame| frame.f_labels.contains_key(&var))
            .unwrap();

        f.f_labels[&var].clone()
    }

    pub fn lookup_d(&self, x: LanguageToken, y: LanguageToken) -> bool {
        self.list.iter().rev().any(|fr| {
            fr.d.contains(&(min(x.clone(), y.clone()), max(x.clone(), y.clone())))
        })
    }

    pub fn lookup_e(&self, stmt: Statement) -> Label {
        let f = self
            .list
            .iter()
            .rev()
            .find(|frame| frame.e_labels.contains_key(&stmt))
            .expect("Bad e");

        f.e_labels[&stmt].clone()
    }

    pub fn make_assertion(&self, stat: Statement) -> Assertion {
        //let _frame = self.list.last_mut().unwrap();

        let e_hyps: Vec<Statement> = self.list.iter().flat_map(|fr| fr.e.clone()).collect();

        let chained = e_hyps.iter().chain(core::iter::once(&stat));

        let mut mand_vars: BTreeSet<LanguageToken> = chained
            .flat_map(|x| x.iter())
            .filter(|tok| self.lookup_v(tok))
            .cloned()
            .collect(); //cloned should do a shallow copy

        // println!("ma: \n mand_vars: {:?}, ", mand_vars);

        let mut cartesian: BTreeSet<(LanguageToken, LanguageToken)> = BTreeSet::new();

        for x in mand_vars.iter() {
            for y in mand_vars.iter() {
                cartesian.insert((x.clone(), y.clone()));
            }
        }

        let dvs: BTreeSet<(LanguageToken, LanguageToken)> = self
            .list
            .iter()
            .flat_map(|fr| fr.d.intersection(&cartesian))
            .cloned()
            .collect();

        let mut f_hyps = VecDeque::new();
        self.list.iter().rev().for_each(|fr| {
            fr.f.iter().rev().for_each(|(v, k)| {
                if mand_vars.contains(v) {
                    f_hyps.push_front((k.clone(), v.clone()));
                    mand_vars.remove(v);
                }
            });
        });
        // println!("ma: \n dvs: {:?}, f: {:?}, e_hyps: {:?}, stat: {:?}", dvs, f_hyps, e_hyps, stat);

        Assertion {
            dvs,
            f_hyps,
            e_hyps,
            stat,
        }
    }
}

// first one is label type,

#[derive(Debug)]
enum LabelEntry {
    DollarA(Assertion),
    DollarP(Assertion),
    DollarE(Statement),
    DollarF(Statement),
}

struct MM {
    fs: FrameStack,
    labels: BTreeMap<Label, Rc<LabelEntry>>,
    begin_label: Option<String>,
    stop_label: Option<String>,
}

impl MM {
    fn new(begin_label: Option<String>, stop_label: Option<String>) -> MM {
        MM {
            fs: FrameStack::default(),
            labels: BTreeMap::new(),
            begin_label,
            stop_label,
        }
    }

    /// Returns true if did not exit
    fn read(&mut self, tokens: &mut Tokens) -> bool {
        // println!("Starting function read");
        self.fs.push();
        let mut label: Option<String> = None;
        let mut tok = tokens.read_comment();
        // println!("In MM read, found token to be {:?}", tok);
        loop {
            match tok.as_deref() {
                Some("$}") => break,
                Some("$c") => {
                    for tok in tokens.read_statement().iter() {
                        self.fs.add_c(tok.clone());
                    }
                }
                Some("$v") => {
                    for tok in tokens.read_statement().iter() {
                        self.fs.add_v(tok.clone());
                    }
                }
                Some("$f") => {
                    let stat = tokens.read_statement();
                    let label_u: Label = label.expect("$f must have a label").into();
                    if stat.len() != 2 {
                        panic!("$f must have length 2");
                    }

                    // println!("{} $f {} {} $.", label_u, stat[0].clone(), stat[1].clone());
                    self.fs
                        .add_f(stat[1].clone(), stat[0].clone(), label_u.clone());
                    let data = LabelEntry::DollarF(Rc::new([stat[0].clone(), stat[1].clone()]));
                    self.labels.insert(label_u, Rc::new(data));
                    label = None;
                }
                Some("$a") => {
                    let label_u = label.expect("$a must have a label");
                    match &self.stop_label {
                        Some(a) if a == &label_u => return false,
                        _ => {}
                    }

                    let data = LabelEntry::DollarA(self.fs.make_assertion(tokens.read_statement()));
                    self.labels.insert(label_u.into(), Rc::new(data));
                    label = None;
                }

                Some("$e") => {
                    let label_u: Label = label.expect("e must have label").into();

                    let stat = tokens.read_statement();
                    self.fs.add_e(stat.clone(), label_u.clone());
                    let data = LabelEntry::DollarE(stat);
                    self.labels.insert(label_u.clone(), Rc::new(data));
                    label = None;
                }
                Some("$p") => {
                    let label_u = label.clone().expect("$p must have elabel");
                    if label == self.stop_label {
                        //could be rewritten better
                        return false;
                    }
                    let stat = tokens.read_statement();
                    let i = stat
                        .iter()
                        .position(|x| x.as_ref() == "$=")
                        .expect("Mmust have $=");
                    let proof = &stat[i + 1..].to_vec();
                    let stat = &stat[..i];

                    if self.begin_label.is_some() && &label_u == self.begin_label.as_ref().unwrap()
                    {
                        self.begin_label = None;
                    }
                    if self.begin_label.is_none() {
                        // println!("verifying {}", label_u);
                        self.verify(label_u.clone(), stat.into(), proof.to_vec());
                    }
                    let data = LabelEntry::DollarP(self.fs.make_assertion(stat.into()));
                    self.labels.insert(label_u.into(), Rc::new(data));
                    label = None;
                }
                Some("$d") => {
                    self.fs.add_d(tokens.read_statement());
                }
                Some("${") => {
                    let out = self.read(tokens);
                    if out == false {
                        return false;
                    }
                }
                Some(x) if !x.starts_with('$') => {
                    label = tok;
                }
                Some(_) => {
                    // print!("tok {:?}", tok);
                }
                None => break,
            }
            tok = tokens.read_comment();
        }
        self.fs.list.pop();
        true
    }

    fn apply_subst(
        &self,
        stat: &Statement,
        subst: &BTreeMap<LanguageToken, Statement>,
    ) -> Statement {
        let mut result: Vec<LanguageToken> = vec![];

        for tok in stat.iter() {
            if subst.contains_key(tok.as_ref()) {
                result.extend(subst[tok.as_ref()].iter().cloned()); //the cloned shouldn't deep copy
            } else {
                result.push(tok.clone());
            }
        }
        result.into()
    }

    fn find_vars(&self, stat: Statement) -> Vec<LanguageToken> {
        let mut vars: Vec<LanguageToken> = vec![];
        for x in stat.iter() {
            if !vars.contains(x) && self.fs.lookup_v(x) {
                vars.push(x.to_owned());
            }
        }

        vars
    }

    fn decompress_and_verify(&mut self, stat: Statement, proof: Proof) {
        // yes I copy pasted this, I know it's bad
        // so please work
        //println!("complete proof {:?}", proof);
        //
        let ep = proof
            .iter()
            .position(|x| x.as_ref() == ")")
            .expect("Failed to find matching parenthesis");

        let mut labels: Vec<Rc<str>> = self.get_labels(Rc::clone(&stat), ep);
        let hyp_end = labels.len(); //when the f and e end
        labels.extend((&proof[1..ep]).iter().cloned());

        let compressed_proof = proof[ep + 1..].join("");

        let label_end = labels.len();

        let proof_indices = Self::get_proof_indices(compressed_proof);
        if proof_indices.is_empty() {
            // we didn't do the proof yet
            return;
        }

        let mut subproofs: Vec<Statement> = vec![]; //stuff tagged  with Zs
                                                    //let mut prev_proofs: Vec<CompressedProof> = vec![]; // when we construct a subproof, we have to know the hyps
        let mut stack: Vec<Statement> = vec![];
        let mut previous_proof: Option<Statement> = None;

        for pf_int in &proof_indices {
            match pf_int {
                None => {
                    let last_proof = previous_proof
                        .as_ref()
                        .expect("Error in decompressing proof, found unexpected Z");
                    subproofs.push(Rc::clone(last_proof));
                }
                Some(i) if *i < hyp_end => {
                    //mandatory hypothesis
                    let label = &labels[*i];
                    let data = Rc::clone(&self.labels[label]);

                    match data.deref() {
                        LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                            // println!("Verifying hypothesis  {:?}", a);
                            let new_prev = self.verify_assertion(a, &mut stack);
                            previous_proof = Some(new_prev);
                        }
                        LabelEntry::DollarF(x) | LabelEntry::DollarE(x) => {
                            stack.push(x.clone());
                            previous_proof = Some(Rc::clone(x))
                        }
                    }
                }

                Some(i) if hyp_end <= *i && *i < label_end => {
                    //one of the given labels in the proof

                    let label_name = &labels[*i];

                    let step_data = Rc::clone(&self.labels[label_name]);

                    match step_data.deref() {
                        LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                            let prev_statement = self.verify_assertion(a, &mut stack);

                            previous_proof = Some(prev_statement);
                        }
                        LabelEntry::DollarE(x) | LabelEntry::DollarF(x) => {
                            previous_proof = Some(Rc::clone(x));
                            stack.push(Rc::clone(x));
                        }
                    }
                }

                Some(i) if label_end <= *i => {
                    // no need to verify something already proved
                    let pf = &subproofs[(*i as usize) - label_end];
                    stack.push(Rc::clone(pf));
                    previous_proof = Some(Rc::clone(pf));
                }
                _ => {
                    panic!("Bad compression")
                }
            }
        }

        if stack.len() > 1 {
            panic!("stack has anentry greater than >1 at end")
        }
        if stack[0] != stat {
            panic!(
                "assertion proved {:?} but does not match expected {:?} ",
                stack[0], stat
            );
        }
    }

    fn get_labels(&self, stat: Statement, _ep: usize) -> Vec<Label> {
        let Assertion {
            dvs: _dm,
            f_hyps: mand_hyp_stmnts,
            e_hyps: hype_stmnts,
            stat: _,
        } = self.fs.make_assertion(stat);
        // println!("mand_hyps_stmnts {:?}", mand_hyp_stmnts);

        let mand_hyps = mand_hyp_stmnts
            .iter()
            .map(|(_k, v)| self.fs.lookup_f(v.clone()));

        let hyps = hype_stmnts.iter().map(|s| self.fs.lookup_e(s.clone()));

        let labels: Vec<Label> = mand_hyps.chain(hyps).collect(); // contains both the mandatory hypotheses and the e println!("Labels {:?}", labels);

        labels
    }

    fn get_proof_indices(compressed_proof: String) -> Vec<Option<usize>> {
        let mut proof_indices: Vec<Option<usize>> = vec![];
        let mut cur_index: usize = 0;

        for ch in compressed_proof.chars() {
            if ch == 'Z' {
                proof_indices.push(None);
            } else if ('A'..='T').contains(&ch) {
                cur_index = 20 * cur_index + (ch as i32 - 'A' as i32 + 1) as usize;
                if cur_index == 0 {
                    panic!("current index was tagged as 0, bad character {}", ch);
                }
                proof_indices.push(Some(cur_index - 1));
                cur_index = 0;
            } else if ('U'..='Y').contains(&ch) {
                cur_index = 5 * cur_index + (ch as i32 - 'U' as i32 + 1) as usize;
            }
        }
        proof_indices
    }

    // fn print_stack(stack: &Vec<Statement>) {
    //     println!(
    //         "stack: {:?}",
    //         stack.iter().map(|x| x.join(" ")).collect::<Vec<String>>()
    //     );
    // }

    fn verify_assertion(&mut self, assertion: &Assertion, stack: &mut Vec<Statement>) -> Statement {
        let Assertion {
            dvs: distinct,
            f_hyps: mand_var,
            e_hyps: hyp,
            stat: result,
        } = assertion;
        let npop = mand_var.len() + hyp.len();
        let sp = stack.len() - npop;
        if stack.len() < npop {
            panic!("stack underflow")
        }
        let mut sp = sp;
        let mut subst = BTreeMap::<LanguageToken, Statement>::new();

        for (k, v) in mand_var {
            let entry: Statement = stack[sp].clone();

            if &entry[0] != k {
                panic!(
                    "stack entry doesn't match mandatry var hypothess, found {} and {}",
                    &entry[0], k
                );
            }

            subst.insert(v.clone(), entry[1..].into());
            sp += 1;
        }

        for (x, y) in distinct {
            let x_vars = self.find_vars(Rc::clone(&subst[x]));
            let y_vars = self.find_vars(subst[y].clone());

            for x in &x_vars {
                for y in &y_vars {
                    if x == y || !self.fs.lookup_d(x.clone(), y.clone()) {
                        panic!("Disjoint violation");
                    }
                }
            }
        }
        for h in hyp {
            let entry = &stack[sp];
            let subst_h = self.apply_subst(h, &subst);
            if entry != &subst_h {
                panic!(
                    "Stack entry: {:?} doesn't match hypothesis {:?}",
                    entry, &subst_h
                );
            }
            sp += 1;
        }

        stack.drain(stack.len() - npop..);
        let substituted = self.apply_subst(result, &subst);
        stack.push(Rc::clone(&substituted));
        substituted
    }

    fn verify(&mut self, stat_label: String, stat: Statement, proof: Proof) {
        let mut stack: Vec<Statement> = vec![];
        let _stat_type = stat[0].clone();
        if proof[0].as_ref() == "(" {
            self.decompress_and_verify(stat, proof);
            return;
        }

        if proof.is_empty() {
            // println!("Did not find proof for {}, skipping", stat_label);
            return;
        }

        for label in proof {
            // println!("label {:?}", label);
            let stepdat = Rc::clone(&self.labels[&label]);
            // println!("{:?} : {:?}", label, self.labels[&label]);

            match stepdat.deref() {
                LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                    self.verify_assertion(a, &mut stack);
                }
                LabelEntry::DollarF(x) | LabelEntry::DollarE(x) => {
                    stack.push(x.clone());
                }
            }
            // // // // println!("st: {:?}", stack);
        }
        if stack.len() != 1 {
            panic!("stack has anentry greater than >1 at end")
        }
        if stack[0] != stat {
            panic!("assertion proved doesn't match ")
        }
    }

    // fn dump(&mut self) {
    //     // println!("{:?}", self.labels);
    // }
}

/// Checks a single file with no imports, given as a path string. Returns whether is succeeded
fn main() {
    let lines: Vec<String> = env::read();
    // let lines: Vec<String> = vec![];

    let mut mm = MM::new(None, None);

    // println!("Found file name {:?}", args[1]);
    // use std::time::Instant;
    // let now = Instant::now();

    // for line in &file_lines {
    //     println!("line: {}", line);
    // }

    let out = mm.read(&mut Tokens::new(lines));
    // mm.dump();
    // let elapsed = now.elapsed();
    // println!("Finished checking in {:.2?}, with result {}", elapsed, out);
    env::commit(&out);
}
