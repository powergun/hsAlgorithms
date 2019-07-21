#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/4

import           Helpers (assert)

len1 :: [Int] -> Int
len1 []     = 0
len1 (_:xs) = 1 + len1 xs

-- use foldl
len2 :: [Int] -> Int
len2 [] = 0
len2 xs = foldl (\n _ -> n + 1) 0 xs

-- use foldr with const
len2c :: [Int] -> Int
len2c [] = 0
len2c xs = foldr ((+) . (const 1)) 0 xs
-- f = (+) . (const 1) elem 0
-- f = 1 + 0
-- ......

len2cc :: [Int] -> Int
len2cc [] = 0
len2cc xs = foldl (const . (+1)) 0 xs
-- f = const (+1) 0 elem
-- f = const 1 elem
-- f = 1
-- ......

-- use accumulator
len3 :: [Int] -> Int
len3 [] = 0
len3 xs = _acc xs 0 where _acc [] n     = n
                          _acc (_:xs) n = _acc xs (n + 1)

verify :: ([Int] -> Int) -> IO ()
verify f = do
  assert 0 $ f []
  assert 1 $ f [1]
  assert 10 $ f [1..10]

main :: IO ()
main = do
  verify len1
  verify len2
  verify len2c
  verify len2cc
  verify len3
