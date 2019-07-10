#!/usr/bin/env stack runghc

-- haskell cookbook L/1494

merge :: Ord a => [a] -> [a] -> [a]
merge [] xs = xs
merge xs [] = xs
merge (x:xs) (y:ys) 
  | x >= y    = y : merge (x:xs) ys
  | otherwise = x : merge xs (y:ys)

main = do
  print $ merge "thereisacow" "asilencewhere"
  print $ merge (map (* 3) [-1..4]) (map (* 2) [-1..3])
