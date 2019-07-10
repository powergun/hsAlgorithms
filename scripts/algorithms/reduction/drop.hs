#!/usr/bin/env stack runghc

-- real world haskell P/70
-- WTF is null
-- http://zvon.org/other/haskell/Outputprelude/null_f.html
-- returns True if a list is empty, otherwise False
dropThis :: Int -> [a] -> [a]
-- indentation continues an existing definition, instead of 
-- starting a new one (don't omit the indentation here)
dropThis n xs = if n <= 0 || null xs
                then xs
                else dropThis (n - 1) (tail xs) 
demoDropThis :: IO ()
demoDropThis = do
    print "//// demo drop this"
    print $ dropThis 13 "thereisacow"
    print $ dropThis 0 "thereisacow"

main :: IO ()
main = do
  demoDropThis
