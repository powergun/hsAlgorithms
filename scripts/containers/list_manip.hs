#!/usr/bin/env stack runghc

-- real world haskell P/118 - P/139
-- http://hackage.haskell.org/package/base-4.12.0.0/docs/Data-List.html

import           Control.Monad (forM_)
import           Data.List

-- intersperse :: a -> [a] -> [a]
-- The intersperse function takes an element and a list
-- and `intersperses' that element between the elements of the list.
-- For example,
-- >>> intersperse ',' "abcde"
-- "a,b,c,d,e"
-- NOTE: similar to python/perl's join
demoJoinList :: IO ()
demoJoinList = do
  print (intersperse 0 [1, 2, 3])
  print (intersperse ',' "iddqd")

demoTailElements :: IO ()
demoTailElements = do
  -- last element
  print (last "iddqd")
  -- tail elements
  print (tail "iddqd")
  -- ALL BUT last
  print (init "iddqd")

-- real world haskell P/236
-- how to work around the issue that maximum() does not accept an
-- empty list
safePrintMaxium xs = do
  -- this won't work:
  -- list_manip.hs: Prelude.maximum: empty list
  -- let a = maximum xs
  let a = (maximum . (Nothing:)) xs
  forM_ a print

demoSafePrintMaximum :: IO ()
demoSafePrintMaximum = do
  print "//// demo safe print maximum (handle exception)"
  safePrintMaxium [Just 1, Just 2]
  safePrintMaxium ([] :: [Maybe Int])

demoUncons :: IO ()
demoUncons = do
  print "//// demo Data.List.uncons"
  print $ uncons [1, 2, 3]
  print $ uncons [1]
  print $ uncons ([] :: [Int])

main :: IO ()
main = do
  demoSafePrintMaximum
  demoUncons
  demoJoinList
  demoTailElements

