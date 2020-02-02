{-# LANGUAGE BangPatterns #-}
module Main (main) where

import qualified CorrectDeque
import           Criterion
import           Criterion.Main   (defaultMain)
import           Data.Maybe       (maybe)
import qualified FromScratchDeque

pushPop :: [Int] -> FromScratchDeque.Queue Int
pushPop ns =
  let q = foldr (\elem summ -> FromScratchDeque.push elem summ) FromScratchDeque.empty ns
      pop' q = maybe FromScratchDeque.empty snd $ FromScratchDeque.pop q
  in foldr (\_ summ -> pop' summ) q ns

pushPop' :: [Int] -> CorrectDeque.Queue Int
pushPop' ns =
  let q = foldr (\elem summ -> CorrectDeque.push elem summ) CorrectDeque.empty ns
      pop' q = maybe CorrectDeque.empty snd $ CorrectDeque.pop q
  in foldr (\_ summ -> pop' summ) q ns

main :: IO ()
main = do
  let !workload = [1..3000]
  defaultMain
    [ bench "naive deque (excessive reverse)" $ whnf pushPop workload
    , bench "correct dequeue (en->de shifting)" $ whnf pushPop' workload
    ]
