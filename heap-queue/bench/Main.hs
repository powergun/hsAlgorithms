module Main (main) where

import           Criterion
import           Criterion.Main      (defaultMain)

import           Data.List           (sort)
import qualified System.Random       as Sr

import qualified PurelyFDS.Leftist   as Leftist
import qualified PurelyFDS.SplayTree as Splay

genList :: Sr.StdGen -> Int -> [Int]
genList g n =
  let gen :: a -> [(Int, Sr.StdGen)] -> [(Int, Sr.StdGen)]
      gen _ xs = (: xs) . Sr.next . snd . head $ xs
  in fmap fst $ foldr gen [Sr.next g] [1..n]

benchSort :: IO ()
benchSort = do
  g <- Sr.getStdGen
  let workload = genList g 100000
  defaultMain
    [ bench "Data.List sort" $ whnf sort workload
    , bench "Leftist Heapsort" $ whnf Leftist.sort workload
    ]

benchFromList :: Int -> IO ()
benchFromList n = do
  g <- Sr.getStdGen
  let workload = genList g n
  defaultMain
    [ bench "fromList : n.log(n)" $ whnf Leftist.fromList workload
    , bench "fromList':   log(n)" $ whnf Leftist.fromList' workload
    ]

benchFindMin :: Int -> IO ()
benchFindMin n = do
  g <- Sr.getStdGen
  let workload = genList g n
      tree = Splay.fromList workload
  defaultMain
    [ bench "find min from list: O(n)" $ whnf minimum workload
    , bench "find min from splay tree: A O(1)" $ whnf Splay.findMin tree
    ]

main :: IO ()
main = do
  -- benchSort
  -- benchFromList 10000
  -- benchFromList 100000
  -- list minimum:  3.155 μs -> 31.30 μs -> 391.2 μs
  -- splay findMin: 27.69 ns -> 34.62 ns -> 49.16 ns
  benchFindMin 1000
  benchFindMin 10000
  benchFindMin 100000
