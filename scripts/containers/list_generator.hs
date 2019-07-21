#!/usr/bin/env stack runghc

-- inspired by
-- https://wiki.haskell.org/Euler_problems/1_to_10
-- motivation:
-- how to generate a numeric sequence with certain internval

data Bean a = Bean a
              deriving (Show, Eq)

demoIncSequence :: IO ()
demoIncSequence = do
  print $ [3,6..20] -- inc-3, not including 20
  print $ [5,10..50] -- inc-5, including 50
  print $ ['a','d'..'k'] -- not including 'k'

  print $ fmap Bean [1..5]

demoDecSequence :: IO ()
demoDecSequence = do
  print $ [10,4..(-22)] -- not including -22

main :: IO ()
main = do
  demoIncSequence
  demoDecSequence
