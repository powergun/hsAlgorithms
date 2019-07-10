#!/usr/bin/env stack runghc

{-# LANGUAGE ScopedTypeVariables #-}

import Data.List
import Control.Exception (SomeException, catch)

l0 :: [Int]
l0 = [1, 2, 3, 4, 5]
l1 :: [Int]
l1 = [1..10]
l2 :: [Int]
l2 = [1, 3..10]
-- infinite list
l3 :: [Int]
l3 = [1..]
l4 :: [String]
l4 = ["aaa", "bbb", "ccc", "ddd"]
l5 :: [Char]
l5 = ['a', 'b', 'c', 'd']
l6 :: [Char]
l6 = "abcd"

type Grid = [String]
grid = [ "xxxxx"
       , "xxxxx"
       , "xxxxx"
       , "xxxxx"
       , "xxxxx"
       ]

outputGrid :: Grid -> String
outputGrid grid = intercalate "\n" grid

skew :: Grid -> Grid
-- for recursive algorithms, it is important to always define the
-- base case first (avoid Non-exhaustive patterns)
skew [] = []
skew (l:ls) =
    let indent line = '_' : line
    in l : skew (map indent ls)

demoListMembership :: IO ()
demoListMembership = do
    print "//// demo list membership (elem)"
    print $ 3 `elem` [3, 1, 4, 5, 9, 2, 6]

demoIsPrefixOf :: IO ()
demoIsPrefixOf = do
    -- real world haskell P/117
    -- if one list matches the beginning of another
    print "//// demo isPrefixOf"
    print $ isPrefixOf [3, 1, 4, 1, 5, 9, 2, 6] [3, 1, 4]

demoIsInfixOf :: IO ()
demoIsInfixOf = do
    -- P/116 needle-haystack test
    print "//// demo isInfixOf"
    print $ "there" `isInfixOf` "set thereisacow 1"

demoListCreation :: IO ()
demoListCreation = do
  let l = ["0001101", "0011001", "0010011", "0111101", "0100011",
           "0110001", "0101111", "0111011", "0110111", "0001011"]
  print l
  -- real world haskell P/311
  print $ map complement <$> l
  print $ map reverse l
  where complement '0' = '1'
        complement '1' = '0'

demoGetElement :: IO ()
demoGetElement = do
  print "//// demo get list element"
  let l = [1, 2, 3]
  print $ l !! 2
  catch (print $ l !! 99) 
        (\(e :: SomeException) -> print e) -- index too large exception

main :: IO ()
main = do
    print l0
    print l1
    print l2
    print (take 20 l3)
    print l4
    print l5
    print l6
    putStrLn $ outputGrid grid
    putStrLn $ outputGrid $ skew grid
    demoListMembership
    demoIsPrefixOf
    demoIsInfixOf
    demoListCreation
    demoGetElement
