module Main where

-- haskell cookbook L3951

import qualified Data.Vector as V
import qualified Data.Vector.Mutable as MV
import Data.Vector ((//), (!), (!?))

demoVectorConstruction :: IO ()
demoVectorConstruction = do
  let e = V.empty :: V.Vector Int
      s = V.singleton "one" :: V.Vector String
      r = V.replicate 5 "same" :: V.Vector String
      g = V.generate 5 (const "generated") :: V.Vector String
      i = V.iterateN 10 ('x':) "o"
                    -- ^^^ 'x' : <prev elem>
  print e
  print s
  print r
  print g
  print i

demoVectorEnumeration :: IO ()
demoVectorEnumeration = do
  -- L3951
  -- enumFromTo() can also be used but it is slower than 
  -- enumFromN
  print (V.enumFromN 1.1 10 :: V.Vector Float)
  print (V.enumFromStepN 1.1 0.5 10 :: V.Vector Float)  

-- L3951
-- vector supports many functions similar to list
-- not that all operations are O(1)
demoVectorAsList :: IO ()
demoVectorAsList = do
  let vec = V.enumFromStepN 1 3 10 :: V.Vector Int
  -- all but the last (behaves like list functions)
  print $ V.init vec
  print $ V.head vec
  print $ V.tail vec
  print $ V.take 3 vec
  print $ V.drop 3 vec
  -- prepend
  print $ V.cons 99 (V.drop 6 vec)
  -- append
  print $ V.snoc (V.drop 6 vec) 99

  -- concatenate vectors
  print $ vec V.++ (V.fromList [101, 102, 103])

demoVectorBulkUpdate :: IO ()
demoVectorBulkUpdate = do
  let vec = V.fromList [2, 3, 4, 5, 6]
  -- replace elements by list of index and value
  print $ vec // [(0, 3), (1, 6), (2, 9)]
  -- update with another vector with index and value
  print $ vec `V.update` (V.fromList [(0, 1), (1, 33)])

demoElementAccessing :: IO ()
demoElementAccessing = do
  let vec = V.enumFromStepN 1.1 0.5 10
  -- access 5-th element
  print $ vec ! 5
  -- safely access 99th element
  print $ vec !? 99

-- L3984
-- mutable vectors are created either in IO or ST monad
-- L4009
-- mutable vector works through monad, by allowing us to 
-- programmatically construct the vector and then freeze it
-- to convert it to an immutable vector
demoMutableVectorCreation :: IO ()
demoMutableVectorCreation = do
  let initMutableVector = do
        v <- MV.new 2 -- create a vector of size 2
        MV.write v 0 33 -- assign all values (index value)
        MV.write v 1 55
        return v
  mv <- initMutableVector
  -- use the mutable vector and freeze() it to convert it to
  -- immutable vector
  vec <- V.freeze mv
  print vec

main :: IO ()
main = do
  demoVectorConstruction
  demoVectorEnumeration
  demoVectorAsList
  demoVectorBulkUpdate
  demoElementAccessing
  demoMutableVectorCreation
