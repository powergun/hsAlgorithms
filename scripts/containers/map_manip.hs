#!/usr/bin/env stack runghc

-- real world haskell P/331

import qualified Data.Map as M

demoInsert :: IO ()
demoInsert = do
  let a = M.fromList [("id", "1")]
  -- recall that modification yields a NEW MAP 
  print $ M.insert "idd" "11" a
  print $ M.insert "id" "101" a
  -- insertWith takes a further combining func.. if no matching
  -- key was present in the map, the new value is inserted verbatim;
  -- otherwise the combining function is called on the NEW and OLD
  -- values, and its result is inserted back

  -- P/342
  -- Maps do not guarantee that they will preserve the original
  -- order of calls to insert
  print $ M.insertWith (++) "id" "x01 - " a

demoDelete :: IO ()
demoDelete = do
  -- returns the map unmodified if the key is not present
  print 1

demoUnion :: IO ()
demoUnion = do
  -- union is left biased 
  print 1

main :: IO ()
main = do
  demoInsert
  demoDelete

