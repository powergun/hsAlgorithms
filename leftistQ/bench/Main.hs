module Main (main) where

import           Criterion
import           Criterion.Main    (defaultMain)

import           Data.List         (sort)
import qualified System.Random     as Sr

import qualified PurelyFDS.Leftist as Leftist

genList :: Sr.StdGen -> Int -> [Int]
genList g n =
  let gen :: a -> [(Int, Sr.StdGen)] -> [(Int, Sr.StdGen)]
      gen _ xs = (: xs) . Sr.next . snd . head $ xs
  in fmap fst $ foldr gen [Sr.next g] [1..n]

main :: IO ()
main = do
  g <- Sr.getStdGen
  let workload = genList g 100000
  defaultMain
    [ bench "Data.List sort" $ whnf sort workload
    , bench "Leftist Heapsort" $ whnf Leftist.sort workload
    ]
