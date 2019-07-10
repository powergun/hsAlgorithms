#!/usr/bin/env stack runghc

demoTupleCreationAndTypes :: IO ()
demoTupleCreationAndTypes = do
  print "//// demo tuple creation and types"
  print t0
  print t1
  print t2
  print t3
  where
    t0 :: (Int, Int)
    t0 = (1234, 5678)
    t1 :: (String, Int, Double)
    t1 = ("Sometext", 8, 3.1415)
    t2 :: ([Int], [String], (Float, Char))
    t2 = ([1, 2, 3, 4], ["aaa", "bbb"], (1.0, 'o'))
    
    -- must have the same tuple types
    t3 = [(1, "there", False), (2, "is", True)]

-- real world haskell P/66
-- fst, snd: defined only for pairs and can't used with tuples
-- of other sizes
-- haskell's type system makes it tricky to write a generialized 
-- get-the-second-element function for any tuple no matter how 
-- wide
demoTupleAsPair :: IO ()
demoTupleAsPair = do
  print "//// demo two-element tuple (pair)"
  print $ fst sut1
  print $ snd sut1
  where 
    sut1 = ("thereis", "acow")

main :: IO ()
main = do
  demoTupleCreationAndTypes
  demoTupleAsPair
