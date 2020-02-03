module Main (main) where

import           Criterion
import           Criterion.Main  (defaultMain)

import           Data.Vector
import qualified PurelyFDS.Lists

doUpdateL :: [Int] -> [Int]
doUpdateL src = PurelyFDS.Lists.update' src 899999 0x1234

doUpdateV :: Vector Int -> Vector Int
doUpdateV vec = vec // [(899999, 0x1234)]

main :: IO ()
main = do
  let sutL = [1..1000000]
      sutV = fromList sutL
  defaultMain
    [ bench "Update list" $ nf doUpdateL sutL
    , bench "Update vector" $ nf doUpdateV sutV
    ]
