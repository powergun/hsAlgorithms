#!/usr/bin/env stack runghc

-- TODO: real world haskell P/118 - P/139
-- TODO: absorb and document list manip techniques
-- TODO: read Data.List hackage page (very nice layout and structure)
-- http://hackage.haskell.org/package/base-4.12.0.0/docs/Data-List.html

import Data.List

-- TODO: list diff function \\

-- TODO:
-- intersperse :: a -> [a] -> [a]
-- The intersperse function takes an element and a list and `intersperses' that element between the elements of the list. For example,
-- >>> intersperse ',' "abcde"
-- "a,b,c,d,e"
-- NOTE: similar to python/perl's join

-- real world haskell P/236
-- how to work around the issue that maximum() does not accept an 
-- empty list
safePrintMaxium xs = do 
  -- this won't work:
  -- list_manip.hs: Prelude.maximum: empty list
  -- let a = maximum xs
  let a = (maximum . (Nothing:)) xs
  case a of
    Nothing -> return ()
    Just v -> print v

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

