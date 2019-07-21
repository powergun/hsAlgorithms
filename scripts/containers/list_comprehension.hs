#!/usr/bin/env stack runghc

-- inspired by
-- https://wiki.haskell.org/Euler_problems/1_to_10
--

demo = sum [ x | x <- takeWhile (<= 300) fibs, even x ]
       where fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = do
  print $ demo
