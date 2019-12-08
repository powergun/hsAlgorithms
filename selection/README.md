# "Selection" functions

I can't find a more proper name for this type of functions...

"three-way" functions? "logic-gate" functions?

leave it as a future TODO for now

basically they are a type of functions that take a some condition
and return the "left arg" in the case of "failure" and "right arg"
in the case of "success" - conceptually similar to how Either
works without the caller to do any pattern-match

## Bool Function

source:

https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Bool.html#v:bool

## Either Function

source:

https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#v:either

## Maybe Function

source:

https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#v:maybe

`fromMaybe`, see: https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Maybe.html#v:fromMaybe

exported from `Data.Maybe`
