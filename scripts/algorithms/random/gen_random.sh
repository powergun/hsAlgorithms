#!/usr/bin/env bash

source "$(dirname $0)/../../ghci_helper.sh"

gen_random() {
    ghci <<'HASKELL'
HASKELL
}

gen_random
