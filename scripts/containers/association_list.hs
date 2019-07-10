#!/usr/bin/env stack runghc

-- real world haskell P/339
-- do not mistake this for hash table 

-- for large data sets, Map will have a considerable performance 
-- advantage

-- association list is just a normal list containing (key, value)
-- tuples,

-- haskell comes with one built-in function called Data.List.lookup
-- it returns a Maybe value
demoLookupValue :: IO ()
demoLookupValue = do
  -- real world haskell P/340
  -- implement Data.List.lookup; linear search
  -- (replacing the builtin lookup with lookup_)
  print $ 'e' `lookup_` acList -- key hit, return Just v
  print $ 'z' `lookup_` acList -- key miss, return Nothing
  where
    acList :: [(Char, Char)]
    acList = zip "thereis" "acow"
    lookup_ :: Eq a => a -> [(a, b)] -> Maybe b
    lookup_ _ [] = Nothing
    lookup_ key ((k, v):rest) =
      if k == key
      then Just v
      else lookup_ key rest

main :: IO ()
main = do
  demoLookupValue
