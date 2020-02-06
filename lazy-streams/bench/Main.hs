module Main (main) where

import           Criterion
import           Criterion.Main   (defaultMain)

import qualified PurelyFDS.Stream as Stream

doFoldList :: Int -> Int
doFoldList n =
  foldr (+) 0 [1..n]

doFoldStream :: Int -> Int
doFoldStream n =
  foldr (+) 0 (Stream.fromList [1..n])

main :: IO ()
main = do
  defaultMain
    [ bench "Foldr on list" $ whnf doFoldList 100000
    , bench "Foldr on stream" $ whnf doFoldStream 100000
    ]
