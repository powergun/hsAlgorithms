#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/5

import           Helpers (assert)

-- this is the wasteful verison
rev1 :: [a] -> [a]
rev1 []     = []
rev1 (x:xs) = (rev1 xs) ++ [x]

-- use accumulator idiom
rev2 :: [a] -> [a]
rev2 [] = []
rev2 xs = rev' xs [] where rev' [] out_     = out_
                           rev' (x:xs) out_ = rev' xs (x:out_)

-- TODO: ???
rev3 :: [a] -> [a]
rev3 xs = foldr (\x fId empty -> fId (x : empty)) id xs []

rev4 :: [a] -> [a]
rev4 = foldl (\a x -> x:a) []

verify f = do
  assert [] $ f []
  assert [1] $ f [1]
  assert [3,2,1] $ f [1..3]
  assert [1, 1, 1] $ f (replicate 3 1)

main :: IO ()
main = do
  verify rev1
  verify rev2
  verify rev3
  verify rev4
