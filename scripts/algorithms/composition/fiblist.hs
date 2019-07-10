#!/usr/bin/env stack runghc

-- haskell cookbook L1261
-- A lazy fibonacci number generator that is O(n) 

fib :: Int -> Integer
fib n = fiblist !! n

fiblist :: [Integer]
fiblist = 0 : 1 : zipWith (+) fiblist (tail fiblist)

-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-- takes a function f and two lists; 
-- take out an element from each list and applies the function f
-- on these two elements
-- the zipWidth function recursively continues this operation
-- until either of the input lists are exhausted

main :: IO ()
main = do
  print $ fib 1000
