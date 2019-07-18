#!/usr/bin/env stack runghc

-- programming haskell L2714
-- remove duplicated elements from a list

-- Data.List / nub

dedup :: Eq a => [a] -> [a]
dedup [] = []
dedup (x:xs) = x : filter (/= x) (dedup xs)
demoDeDup :: IO ()
demoDeDup = do
    print $ dedup [3, 1, 4, 1, 5, 9, 2, 6, 1, 1, 1]

main :: IO ()
main = do
    demoDeDup
