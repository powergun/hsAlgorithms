#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/Simple_Unix_tools
import Data.List (nub)

main :: IO ()
main = do
  print $ nub ([1..10] ++ [1..10] ++ [1..10])
