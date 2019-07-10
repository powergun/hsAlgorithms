#!/usr/bin/env stack runghc

import Data.Char

-- programming haskell L2619
-- higher order function iterate, produces an infinite list 
-- by applying a function an increasing number of times to 
-- a value

weightsIterate = iterate (*2) 1
weightsMap =  [ 2 ^ n | n <- [0..] ]
demoWeights :: IO ()
demoWeights = do
    print "weights by iterate"
    print $ take 6 $ weightsIterate
    print "weights by map"
    print $ take 6 $ weightsMap

bitsToWeights :: [Int] -> [Int]
bitsToWeights ns = [ n * w | (n, w) <- zip ns weights ]
    where
        weights = iterate (*2) 1
demoBitsToWeights :: IO ()
demoBitsToWeights = do
    print "demo generate weight map from bits"
    print $ bitsToWeights [1, 1, 0, 0, 1, 0, 1, 0]

bitsToInt :: [Int] -> Int
bitsToInt = foldr (\n1 n2 -> n1 + 2 * n2 ) 0
demoBitsToInt :: IO ()
demoBitsToInt = do
    print "demo bits to int (0x7F ==> 127)"
    print $ bitsToInt [1, 1, 1, 1, 1, 1, 1]

intToBits :: Int -> [Int]
intToBits 0 = []
intToBits n = n `mod` 2 : intToBits (n `div` 2)
demoIntToBits :: IO ()
demoIntToBits = do
    print "demo int to bits (255 ==> 0xFF)"
    print $ intToBits 255

-- programming haskell L2673
-- to encode an ascii string in binary form
encode :: String -> [Int]
encode = concat . map (make8 . intToBits . ord)
    where
        make8 ns = take 8 (ns ++ repeat 0)
demoEncode :: IO ()
demoEncode = do
    print "demo encode"
    print $ encode "there"
    print $ encode "\x7f\x4f"

main :: IO ()
main = do
    demoWeights
    demoBitsToWeights
    demoBitsToInt
    demoIntToBits
    demoEncode
