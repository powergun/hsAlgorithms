#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/Simple_Unix_tools

main :: IO ()
main = do
  print $ take 20 (cycle [1..3])
