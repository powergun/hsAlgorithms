#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/8

compress :: Eq a => [a] -> [a]
compress [] = []

main :: IO ()
main = do
  print 1
