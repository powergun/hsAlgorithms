#!/usr/bin/env stack runghc

main :: IO ()
main = do
  -- para con haskell L623
  -- split a list in two (almost) equal parts
  let sut = [1..11]
  print $ splitAt (length sut `div` 2) sut
