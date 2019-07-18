#!/usr/bin/env stack runghc
 
-- source
-- https://wiki.haskell.org/Simple_Unix_tools

-- Count number of characters in a file (like wc -c)
-- wc_c    = showln . length
 
-- Count number of lines in a file, like wc -l
-- wc_l    = showln . length . lines

-- Count number of words in a file (like wc -w)
-- wc_w    = showln . length . words

main :: IO ()
main = do
  print 1
