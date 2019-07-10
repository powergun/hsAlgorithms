#!/usr/bin/env stack runghc

-- haskell cookbook L1055
-- demonstrate the tail recurstion, "Worker Pattern"
-- L1116
-- The compiler optimizes the tail recursion functions such that
-- they are executed in constant space and without adding them
-- to stack
-- see:
-- https://stackoverflow.com/questions/310974/what-is-tail-call-optimization
-- see also: 
-- http://wiki.c2.com/?TailCallOptimization
-- "A "smarter" compiler would simply multiply and GoTo the start of bar. "

-- conditionally import Prelude, hiding the reverse function
-- MY NOTE:
-- can be useful for testing or comparing custom impls to standard 
-- impls
import Prelude hiding (reverse)

reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = (reverse xs) ++ [x] -- not tail recur, bad

-- haskell cookbook L1108
-- rev function takes N steps where N is the number of elements
-- in the input list. This pattern, where we use a worker func
-- and store the result as an argument is called a "Worker Pattern"
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = rev [x] xs
  where
    rev :: [a] -> [a] -> [a]
    rev result [] = result -- case to stop recur
    rev result (n:ns) = rev ([n] ++ result) ns -- tail recur
                                               -- "the last thing"

main :: IO ()
main = do
  print $ reverse  [1..10]
  print $ reverse' [1..10]
