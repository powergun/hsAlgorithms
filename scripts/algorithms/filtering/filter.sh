#!/usr/bin/env bash

source "$(dirname $0)/../../ghci_helper.sh"

do_filter() {
    ghci <<'HASKELL'
div2 x = x `mod` 2 == 0
filter div2 $ take 10 [1..]
take 10 $ filter div2 [1..]
HASKELL
}

do_filter
