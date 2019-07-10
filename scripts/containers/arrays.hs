#!/usr/bin/env stack runghc

import Data.Array

-- real world haskell P/310
-- the barcode encoding process can largely be table-driven,
-- in which we use small tables of bit patterns to decide how 
-- to encode each digit
-- haskell's bread-and-butter data types: lists and tuples, are
-- not well-suited to use for tables whose elements may be 
-- accessed randomly
-- a list has to be traversed linearly to reach the k-th elem
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- a tuple does not have this problem, but haskell's type system
-- makes it difficult to write a function that takes a tuple and 
-- and element offset and returns the element at that offset 
-- within the tuple

listToArray :: [a] -> Array Int a
-- real world haskell P/311
-- listArray populates an array from a list.
-- it takes as its first parameter the bounds of the array to 
-- create; the second is the values with which to populate it
-- P/312
-- is parameterized over both the data it contains and the index 
-- type; for example the type of one-dimensional array of String 
-- is Array Int String, but a 2d array would have the type 
-- Array (Int, Int) String
listToArray xs = listArray (0, l - 1) xs
  where l = length xs

demoListToArray :: IO ()
demoListToArray = do
  let l = ["0001101", "0011001", "0010011", "0111101", "0100011",
           "0110001", "0101111", "0111011", "0110111", "0001011"]
      a = listToArray l
  print a

demoStringToArray :: IO ()
demoStringToArray = do
  -- lower and upper bounds are inclusive
  print $ listArray (0, 5) "thereisacow"
  -- undefined array element (out out bound)
  -- P/313 lazy array allows undefined elements but a runtime
  -- error is thrown if caller tries to make use of these undefs
  -- print $ listArray(0, 60) "thereisacow"

demoGetElement :: IO ()
demoGetElement = do
  let a = listArray (0, 5) "thereisacow"
  print $ a ! 3
  -- Ix{Integer}.index: Index (100) out of range ((0,5))
  -- print $ a !100

demoCustomIndices :: IO ()
demoCustomIndices = do
  -- (-9, 5)
  -- ('a', 'h')
  let a = listArray (0, 5) "thereisacow"
      b = listArray ('a', 'h') "thereisacow=1"
  print $ b ! 'd'

demoHighDimensionArray :: IO ()
demoHighDimensionArray = do
  let a = listArray ((0, 0, 0), (2, 2, 2)) [0..]
  print $ a ! (1, 2, 0)

main :: IO ()
main = do
  demoListToArray
  demoStringToArray
  demoGetElement
  demoCustomIndices
  demoHighDimensionArray
