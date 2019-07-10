#!/usr/bin/env stack runghc

import Data.List

-- real world haskeel P/26
minima :: Ord a => Int -> [a] -> [a]
minima k xs = take k (sort xs)
demoKSmallestElements :: IO ()
demoKSmallestElements = do
  print "//// demo k-smallest elements"
  print $ minima 4 [3, 14, 1, 59, 2, 65, 35, 8, -97]

main :: IO ()
main = do
  demoKSmallestElements
