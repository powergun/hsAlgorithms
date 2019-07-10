#!/usr/bin/env bash

source "$(dirname $0)/../../ghci_helper.sh"

do_zip() {
    ghci <<'HASKELL'
-- in this case the result list is
-- [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]
-- zip stops processing when any of the operands reach the end
-- recall Python's builtin zip() use the same rule
zip [1..5] ['a'..'j']
HASKELL
}

do_zip
