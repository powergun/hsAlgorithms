module FirstPrinciples.Vector ( profSlice
                              , profFusion
                              , profBatchUpdate
                              ) where

import           Criterion.Main (bench, defaultMain, whnf)
import           Data.Vector    ((//))
import qualified Data.Vector    as V

sliceNaive :: Int -> Int -> [a] -> [a]
sliceNaive from len xs =
  take len (drop from xs)

l :: [Int]
l = [1..1000]

v :: V.Vector Int
v = V.fromList [1..1000]

-- fusion:
-- First Principles, P/1137

testV' :: Int -> V.Vector Int
testV' n = V.map (+n)
         $ V.map (+n)
         $ V.map (+n)
         $ V.map (+n)
         (V.fromList [1..10000])

testV :: Int -> V.Vector Int
testV n = V.map
          ( (+n)
          . (+n)
          . (+n)
          . (+n)
          ) (V.fromList [1..10000])

-- batch update vector
-- First Principle P/1138
vec :: V.Vector Int
vec = V.fromList [1..10000]

slow :: Int -> V.Vector Int
slow n = go n vec
  where
    go 0 v = v
    go n v = go (n-1) (v // [(n, 0)])

batchList :: Int -> V.Vector Int
batchList n = vec // updates
  where
    updates = fmap (\n -> (n, 0)) [0..n]

batchVector :: Int -> V.Vector Int
batchVector n = V.unsafeUpdate vec updates
  where
    updates = fmap (\n -> (n, 0)) (V.fromList [0..n])

profSlice :: IO ()
profSlice = defaultMain
  [ bench "//// slicing list" $
    whnf (head . sliceNaive 100 900) l
  , bench "//// slicing vector" $
    whnf (V.head . V.slice 100 900) v
  ]

profFusion :: IO ()
profFusion = defaultMain
  [ bench "//// vector map prefused" $
    whnf testV 9998
  , bench "//// vector map will be fused" $
    whnf testV' 9998
  ]

profBatchUpdate :: IO ()
profBatchUpdate = defaultMain
  [ bench "slow" $
    whnf slow 9998
  , bench "batch list" $
    whnf batchList 9998
  , bench "batch vector (faster)" $
    whnf batchVector 9998
  ]
