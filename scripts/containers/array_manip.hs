#!/usr/bin/env stack runghc

import Data.Array

-- real world haskell P/313
-- P/314 array folding does not translate to high dimensional 
-- arrays (therefore Array does not define this function)
foldA :: Ix k => (a -> b -> a) -> a -> Array k b -> a
--                     f        init    arr       ret
foldA f s a = go s (indices a)
  where
    go s (j:js) =
      let s' = f s (a ! j)
      -- WTF is seq 
      -- seq :: a -> b -> b takes two arguments of any type, and 
      -- returns the second
      -- https://wiki.haskell.org/Seq
      -- when the result of seq is evaluated, the first argument 
      -- must also (sort of; see below) be evaluated
      in s' `seq` go s' js
    go s _ = s

demoArrayFold :: IO ()
demoArrayFold = do
  let a = listArray (0, 3) [1, 2, 3, 4]
  print $ foldA (*) 1 a
  print $ foldA' (*) 1 a

main :: IO ()
main = do
  demoArrayFold

