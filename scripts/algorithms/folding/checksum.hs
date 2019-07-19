#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/Simple_Unix_tools

import Data.Char (ord)

-- cksum = foldl k 5381
--   where
--     k h c = h * 33 + ord c

checksum :: [String] -> Int
checksum lines =
  foldl k 5381 lines
  where
    k :: Int -> [Char] -> Int
    k n line = 
      foldl (\_sum c -> _sum * 33 + ord c) 0 line + n

main :: IO ()
main = do
  print $ checksum ["there", "is", "a", "cow"]
