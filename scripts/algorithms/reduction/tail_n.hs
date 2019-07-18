#!/usr/bin/env stack runghc

-- inspired by
-- https://wiki.haskell.org/Simple_Unix_tools

tailN :: Int -> [a] -> [a]
tailN _ [] = []
tailN 0 _ = []
tailN n seq =
  let l = length seq
  in case (n < 0) of
       True -> []
       otherwise -> drop ((flip (-) n) (length seq)) seq

-- this is directly copied from
-- https://wiki.haskell.org/Simple_Unix_tools
tailN' n = 
  drop =<< subtract n . length

demoTailN :: IO ()
demoTailN = do
  print $ tailN 4 ([] :: [Int])
  print $ tailN (-4) [1..20]
  print $ tailN (123) [1..20]
  print $ tailN 4 [1..20]

  print $ tailN' 4 ([] :: [Int])
  print $ tailN' (-4) [1..20]
  print $ tailN' (123) [1..20]
  print $ tailN' 4 [1..20]

main :: IO ()
main = do
  demoTailN
