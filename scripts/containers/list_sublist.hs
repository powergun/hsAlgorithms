#!/usr/bin/env stack runghc

-- real world haskell P/122

-- take, drop
-- takeWhile, dropWhile

main :: IO ()
main = do
  print $ takeWhile (/= 10) [1..]
  print $ dropWhile (< 10) [1..12]
