use risc0_build::{GuestOptions};
use std::{collections::HashMap};

fn main() {

    let inner_pkg_options = GuestOptions {
        code_limit: 13,
        features: vec![],
    };

    let map = HashMap::from([("methods-guest", inner_pkg_options)]);

    risc0_build::embed_methods_with_options(map);
}
