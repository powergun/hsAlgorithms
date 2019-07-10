#!/usr/bin/env bash

source "$(dirname $0)/../ghci_helper.sh"

list() {
    ghci <<'HASKELL'
import Data.List
:type intercalate
intercalate "/" ["", "doom", "e1", "m1", "creatures", "imp"]
formatList s e sep xs = s ++ (intercalate sep (map show xs)) ++ e
formatList "(" ")" ", " [1, 2, 3, 4]
HASKELL
}

list_modification() {
    ghci << 'HASKELL'
-- list concat works similar to string concat (because strings
-- are alias to lists)

-- range is inclusive
[1..3] ++ [5..8]

-- list transpose
-- https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-List.html#v:transpose
putStrLn "list transpose"
import Data.List
transpose [[1,2,3],[4,5,6]]

HASKELL
}

list_elements() {
    ghci << 'HASKELL'
-- head and tail element(s)
head [1, 2, 3]
tail [1, 2, 3]

-- one can iteratively process head and tail
head [1, 2, 3]
tail [1, 2, 3]
head [2, 3]
tail [2, 3]
head [3]
tail [3]
-- empty list

print "init and last"
init [1, 2, 3]
last [1, 2, 3]

-- get element
putStrLn "get element of list"
[1..3] !! 0
HASKELL
}

main() {
    list
    list_modification
    list_elements
}

main
