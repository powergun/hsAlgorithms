module FirstPrinciples.Vector (profSlice, profFusion) where

import           Criterion.Main (bench, defaultMain, whnf)
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
