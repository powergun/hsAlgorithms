module FirstPrinciples.Vector (sliceNaive) where

import qualified Data.Vector as V

sliceNaive :: Int -> Int -> [a] -> [a]
sliceNaive from len xs =
  take len (drop from xs)
