#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/6

import           Helpers (assert)

pal1 xs = xs == (reverse xs)

pal2 xs@(_:_:_) = (head xs) == (last xs) && (pal2 $ init $ tail xs)
pal2 _          = True

verify f = do
  assert True $ f ""
  assert True $ f "a"
  assert True  $ f "aa"
  assert True  $ f "aba"
  assert False $ f ['a'..'z']

main :: IO ()
main = do
  verify pal1
  verify pal2
