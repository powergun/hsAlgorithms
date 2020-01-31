module Main (main) where

import qualified FirstPrinciples.Vector
import qualified FirstPrinciples.VectorMutable

main :: IO ()
main = do
  -- FirstPrinciples.Vector.profSlice
  -- FirstPrinciples.Vector.profFusion
  -- FirstPrinciples.Vector.profBatchUpdate
  FirstPrinciples.VectorMutable.profMutableUpdate
