{-# LANGUAGE BangPatterns #-}
module Main (main) where

import qualified CorrectDeque
import           Criterion
import           Criterion.Main   (defaultMain)
import           Data.Maybe       (maybe)
import qualified FromScratchDeque

pushPop :: [Int] -> Int
pushPop ns =
  let q = foldr (\elem summ -> FromScratchDeque.push elem summ) FromScratchDeque.empty ns
      pop' q = maybe FromScratchDeque.empty snd $ FromScratchDeque.pop q
      qo = foldr (\_ summ -> pop' summ) q ns
  in (FromScratchDeque.length qo)

pushPop' :: [Int] -> Int
pushPop' ns =
  let q = foldr (\elem summ -> CorrectDeque.push elem summ) CorrectDeque.empty ns
      pop' q = maybe CorrectDeque.empty snd $ CorrectDeque.pop q
      qo = foldr (\_ summ -> pop' summ) q ns
  in (CorrectDeque.length qo)

main :: IO ()
main = do
  let !workload = [1..3000]
  defaultMain
    [ bench "naive deque (excessive reverse)" $ nf pushPop workload
    , bench "correct dequeue (en->de shifting)" $ nf pushPop' workload
    ]
