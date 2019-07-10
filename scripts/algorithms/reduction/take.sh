#!/usr/bin/env bash

source "$(dirname $0)/../../ghci_helper.sh"

head_tail() {
    ghci <<'HASKELL'
-- work with infinite list
head [1..]
head $ tail [1..]
head . tail . tail $ [1..]

-- use the convenient operator !!
[1..] !! 0
[1..] !! 5
[1..] !! 100
HASKELL
}

take() {
    ghci <<'HASKELL'
take 10 [1..]
take 10 $ map (*2) [1..]
takeWhile (<10) [0..]
HASKELL
}

head_tail
take
