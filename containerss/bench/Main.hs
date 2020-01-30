module Main (main) where

import           FirstPrinciples.Vector

import           Criterion.Main
import qualified Data.Vector            as V

l :: [Int]
l = [1..1000]

v :: V.Vector Int
v = V.fromList [1..1000]

main :: IO ()
main = defaultMain
  [ bench "slicing list" $
    whnf (head . sliceNaive 100 900) l
  , bench "slicing vector" $
    whnf (V.head . V.slice 100 900) v
  ]
