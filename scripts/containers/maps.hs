#!/usr/bin/env stack runghc
{-# LANGUAGE ScopedTypeVariables #-}

-- real world haskell P/329
-- a brief intro to maps
-- map is strict in its keys, but non-strict in its values.
-- in other words, the spine, or structure of the map is always 
-- kept up-to-date, but values in the map aren't evaluated 
-- unless we force them to be

-- reald world haskell P/341
-- internally a map is implemented as a balanced binary tree
-- (maps) compared to a hash table, this is a much more efficient
-- representation in a language with immutable data. 

import qualified Data.Map as M

demoMapCreation :: IO ()
demoMapCreation = do
  print "//// demo map creation"
  -- printing empty results in an error unless the key-type is 
  -- specified (using the scoped type variable)
  let (empty :: M.Map Int Int) = M.empty
  print $ empty
  print $ M.fromList [("foo", True)]
  print $ M.singleton "foo" True
  
  -- create a map from an association list
  print "-- fromList"
  print $ M.fromList [("name", "hell's gate"), ("code", "e1m1")]

  -- P/342
  -- create a map representation of al by doing a fold
  print "-- mapFold"
  print $ mapFold
  where
    mapFold =
      foldl (\map (k, v) -> M.insert k v map) M.empty 
        [("name", "hell's gate"), ("code", "e1m1")]

demoLookup :: IO ()
demoLookup = do
  print "//// demo map lookup"
  let (empty :: M.Map Int Int) = M.empty
  print $ M.lookup 123 empty 
  print $ M.lookup "iddqd" $ M.fromList [("iddqd", "idkfa")]
  -- findWithDefault
  -- https://downloads.haskell.org/~ghc/6.12.2/docs/html/libraries/containers-0.3.0.0/Data-Map.html#3
  print $ M.findWithDefault "idnoclip" "idfa" $ M.fromList [("a", "b")]
  -- (!) will throw an error if key miss
  print $ M.fromList [("a", "b")] M.! "a"

-- real world haskell P/343
-- functions are data
data CustomColor =
  CustomColor { red :: Int, green :: Int, blue :: Int }
    deriving (Eq, Show, Read)

data FuncRec =
  FuncRec { name :: String, colorCalc :: Int -> (CustomColor, Int) }

-- recall binparse / Parse uses a similar pattern to define a 
-- "method-like" function that is encapsulated in the parsers
demoFunctionAsData :: IO ()
demoFunctionAsData = do
  print "//// demo function as data"
  print $ name plus5
  print $ (colorCalc plus5) 7
  print $ (colorCalc always0) 7
  where
    plus5func color x = (color, x + 5)
    purple = CustomColor 255 0 255
    plus5 = FuncRec { name = "plus5", colorCalc = plus5func purple }
    always0 = FuncRec { name = "always0", colorCalc = \_ -> (purple, 0) }

-- P/344
-- making a piece of data available in multiple places
data FuncRecB = FuncRecB { title :: String, calc :: Int -> Int, namedCalc :: Int -> (String, Int) }
mkFuncRecB :: String -> (Int -> Int) -> FuncRecB
mkFuncRecB name calcfunc =
  FuncRecB { title = name, calc = calcfunc, namedCalc = \x -> (name, calcfunc x) }
demoFunctionAsSharedData :: IO ()
demoFunctionAsSharedData = do
  print "//// demo function as shared data"
  print $ title plus5
  print $ (namedCalc plus5) 5
  -- P/344
  -- notice the creation.. we changed title field but not the 
  -- namedCalc field. THat's why title has the new name but namedCalc
  -- still returns the name that was passed to mkFuncRecB
  let plus5a = plus5 { title = "DOOM" }
  print $ (namedCalc plus5) 5
  where
    plus5 = mkFuncRecB "plus5" (+ 5)
    always0 = mkFuncRecB "always0" (\_ -> 0)

main :: IO ()
main = do
  demoMapCreation
  demoLookup
  demoFunctionAsData
  demoFunctionAsSharedData

