#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/7

import           Helpers (assert)

data NestedList ValueT = Elem a 
                       | List [NestedList a] 
                  deriving (Show, Eq)

flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List x) = concatMap flatten x

verify f =
  assert [5] $ f (Elem 5)
  -- assert ([1,2,3,4,5] :: [Int]) $ f (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])

main :: IO ()
main = do
  verify flatten
