#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/7

import           Helpers (assert)

data NestedList a = Elem a | List [NestedList a] deriving (Show, Eq)

flat1 []     = []
flat1 [x]    = [x]
flat1 (x:xs) = concatMap flat1 xs

verify f =
  assert [] $ f []
  assert [1] $ f [1]
  assert [1, 2] $ f [1, [2]]
  assert [1, 2, 3, 4, 5] $ f [1, [2, [3, [4, [5]]]]]

main :: IO ()
main = do
  print 1
