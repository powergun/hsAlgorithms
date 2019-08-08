#!/usr/bin/env stack runghc

import           Data.Bits

-- real world haskell P/162
-- see also the table P/186
demoShift :: IO ()
demoShift = do
  print "//// demo shift"
  print $ (0xFF00 :: Int) `shiftR` (8 :: Int)

demoAnd :: IO ()
demoAnd = do
  print "//// demo and"
  print $ (0xFF :: Int) .&. (0xFF01 :: Int)

demoHighLowPartition :: Int -> IO ()
demoHighLowPartition n = do
  print "//// demo partition high and low bits"
  print (show a ++ show b)
  where
    b = n .&. (0xFFFF :: Int)
    a = (n .&. (0xFF0000 :: Int)) `shiftR` (16 :: Int)

main :: IO ()
main = do
  demoShift
  demoAnd
  demoHighLowPartition 0x7803e7
