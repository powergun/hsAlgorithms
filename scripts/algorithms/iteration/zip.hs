#!/usr/bin/env stack runghc

-- programming haskell L1611

adjacentPairs :: [a] -> [(a, a)]
adjacentPairs xs = zip xs (tail xs)
demoAdjacentPairs :: IO ()
demoAdjacentPairs = do
    print "demo adjacent pairs"
    print $ adjacentPairs [3, 1, 4, 1, 5, 9]

isSorted :: Ord a => [a] -> Bool
isSorted xs = and ([ x < y | (x, y) <- adjacentPairs xs])
demoIsSorted = do
    print "demo isSorted"
    print $ isSorted [1, 3, 4, 5, 9, 11]
    print $ isSorted [1, 3, 4, 5, 9, 11, 1]

-- programming haskell L1629

withIndex :: [a] -> [(Int, a)]
withIndex xs = zip [0..] xs
demoWithIndex :: IO ()
demoWithIndex = do
    print $ withIndex "thereisacow"

-- haskell design pattern P/45
demoZipWithFunction :: IO ()
demoZipWithFunction = do
    let funcs = [(* 2), (* 3), (* 5)]
    print $ zipWith (\func value -> func (value)) funcs [10, 20, 30]

-- source
-- https://wiki.haskell.org/Simple_Unix_tools
demoAddLineNumber :: IO ()
demoAddLineNumber = do
  print $ zipWith f [1..] ["there", "is", "a", "cow"]
  where
    f n l = (show n) ++ l

main :: IO ()
main = do
    demoAdjacentPairs
    demoIsSorted
    demoWithIndex
    demoZipWithFunction
    demoAddLineNumber
