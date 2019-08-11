#!/usr/bin/env stack runghc

-- real world haskell P/120

main :: IO ()
main = do
  print $ all (/= 0) [1, 0, 1]
  -- notElem 0 [1, 0, 1]
  print $ any (/= 0) [1, 0, 1]
