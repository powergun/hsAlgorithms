module SimpleRandom.Impl (demo) where

-- http://hackage.haskell.org/package/random-1.1/docs/System-Random.html

import qualified System.Random as Sr

demoGenList :: Int -> IO ()
demoGenList n = do
  let gen :: a -> [(Int, Sr.StdGen)] -> [(Int, Sr.StdGen)]
      gen _ xs = (: xs) . Sr.next . snd . head $ xs
  g <- Sr.getStdGen
  print $ fmap fst $ foldr gen [Sr.next g] [1..n]

demoNext :: IO ()
demoNext = do
  let g = Sr.mkStdGen 21
  let (num, g') = Sr.next g
  print num

demo :: IO ()
demo = do
  print "//// Random number demo"
  demoNext
  demoGenList 10
