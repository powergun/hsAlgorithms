#!/usr/bin/env stack runghc

import Data.List

-- programming haskell L2729
-- see ranked voting
-- https://en.wikipedia.org/wiki/Ranked_voting

count :: Eq a => a -> [a] -> Int
count x xs = sum [ 1 | n <- xs, n == x ]
demoCount :: IO ()
demoCount = do
    print "demo count frequency"
    print $ count "ID" ["ID", "IDDQD", "IDKFA", "ID", "ID"]

dedup :: Eq a => [a] -> [a]
dedup [] = []
dedup (x:xs) = x : filter (/= x) (dedup xs)
vote :: Ord a => [a] -> [(Int, a)]
-- sort comes from Data.List
vote xs = sort [ (count n xs, n) | n <- (dedup xs) ]
demoVoting :: IO ()
demoVoting = do
    print "demo naive voting algorithm"
    print $ vote "seta developer_mode 1"

candidates = ["ABC", "BAC", "CAB", "C", "A", "B", "BA", "BC"]
removeEmpty :: Eq a => [[a]] -> [[a]]
removeEmpty xs = filter (/= []) xs
elim :: Eq a => a -> [[a]] -> [[a]]
elim x = map (filter (/= x))
-- snd
-- http://zvon.org/other/haskell/Outputprelude/snd_f.html
-- return the second item in a tuple
rank :: Ord a => [[a]] -> [a]
rank = map snd . vote . map head
winner' :: Ord a => [[a]] -> a
winner' bs = case rank (removeEmpty bs) of
                [c] -> c
                (c:cs) -> winner' (elim c bs)
demoBallot :: IO ()
demoBallot = do
    print "demo rank"
    print $ rank candidates
    print "demo ballot vote algorithm"
    print $ winner' candidates

main :: IO ()
main = do
    demoCount
    demoVoting
    demoBallot
