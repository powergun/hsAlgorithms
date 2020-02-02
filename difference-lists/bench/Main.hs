module Main (main) where

import           Criterion
import           Criterion.Main (defaultMain)
import           Data.DList     as DL
import           FromScratch    as MYDL

schlemiel :: Int -> [Int]
schlemiel i = go i []
  where
    go 0 xs = xs
    go n xs = go (n-1) ([n] ++ xs)

constructDlist :: Int -> [Int]
constructDlist i = DL.toList $ go i DL.empty
  where
    go 0 xs = xs
    go n xs = go (n-1) (DL.singleton n `DL.append` xs)

constructMYDlist :: Int -> [Int]
constructMYDlist i = MYDL.toList $ go i MYDL.empty
  where
    go 0 xs = xs
    go n xs = go (n-1) (MYDL.singleton n `MYDL.append` xs)

main :: IO ()
main = defaultMain
  [ bench "concat list" $ whnf schlemiel 123456
  , bench "concat dlist" $ whnf constructDlist 123456
  , bench "concat my-dlist" $ whnf constructMYDlist 123456
  ]
