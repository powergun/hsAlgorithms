module Main (main) where

import           Criterion
import           Criterion.Main (defaultMain)
import           Data.List      (sort)
import qualified System.Random  as Sr

import qualified PurelyFDS.BST  as BST

genList :: Sr.StdGen -> Int -> [Int]
genList g n =
  let gen :: a -> [(Int, Sr.StdGen)] -> [(Int, Sr.StdGen)]
      gen _ xs = (: xs) . Sr.next . snd . head $ xs
  in fmap fst $ foldr gen [Sr.next g] [1..n]

sortBench :: IO ()
sortBench = do
  g <- Sr.getStdGen
  let workload = genList g 100000
  defaultMain
    [ bench "sort list using list-sort" $ whnf sort workload
    , bench "sort list using BST-sort" $ whnf BST.sort' workload
    ]

memberBench :: IO ()
memberBench = do
  g <- Sr.getStdGen
  let workload = genList g 1000000
      tree = BST.fromList' workload
      runner' = flip BST.member' tree
      runner'' = flip BST.member'' tree
  defaultMain
    [ bench "membership using slow member()" $ whnf runner' 0
    , bench "membership using optm member()" $ whnf runner'' 0
    ]

main :: IO ()
main = do
  sortBench
  -- memberBench
