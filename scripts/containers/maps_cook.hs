#!/usr/bin/env stack runghc

-- haskell cookbook L3796

import qualified Data.Map.Strict as M

-- L3811
-- it takes function that looks at the key and the value and 
-- possibly produces another value
-- this can result in either replacing a value or deleting the 
-- key-value pair in the map
demoUpdateWithKey :: IO ()
demoUpdateWithKey = do
  let updater "an"    k | (k > 5) = Nothing
                        | otherwise = Just (k + 1)
      mp = M.fromList [("a", 1), ("an", 11), ("an", -12)]
  print (M.updateWithKey updater "an" mp)

demoUnion :: IO ()
demoUnion = do
  let mp1 = M.fromList [("th", 1), ("er", 2)]
      mp2 = M.fromList [("th", 30), ("er", 333)]
  -- not updating existing values
  print (M.union mp1 mp2)
  -- have the option to update existing values
  print (M.unionWith (+) mp1 mp2)

main :: IO ()
main = do
  print (M.empty :: M.Map Int Int)
  print (M.singleton 1 "h" :: M.Map Int String)
  print (M.fromList [(1, "th"), (2, "er")] :: M.Map Int String)

  -- override existing value
  print (M.insert 1 "er" $ M.fromList [(1, "th"), (2, "er")])

  -- L3811
  -- use insertWith() function, it gives the ability to look at
  -- the old value in the map, and gives the chance to use the 
  -- new value to construct the new value
  print (M.insertWith (+) "a" 2 $ M.fromList [("a",10), ("an",2), ("the", 8)])
  
  -- ignore key-miss
  print (M.delete 11 $ M.fromList [(1, "th"), (2, "er")])
  print (M.delete 1 $ M.fromList [(1, "th"), (2, "er")])

  demoUpdateWithKey
  demoUnion
