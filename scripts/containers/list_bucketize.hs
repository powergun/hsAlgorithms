#!/usr/bin/env stack runghc

bucketize :: [Int] -> [[Int]]
bucketize [] = []
bucketize ns = take 4 ns : bucketize (drop 4 ns)
demoBucketize :: IO ()
demoBucketize = do
    print $ bucketize [3, 1, 4, 1, 5, 9, 2, 6]

main :: IO ()
main = do
    demoBucketize
