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

main :: IO ()
main = do
  g <- Sr.getStdGen
  let workload = genList g 1000000
  defaultMain
    [ bench "sort list using list-sort" $ whnf sort workload
    , bench "sort list using BST-sort" $ whnf BST.sort' workload
    ]
