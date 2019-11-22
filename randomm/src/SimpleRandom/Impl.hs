module SimpleRandom.Impl (demo) where

-- http://hackage.haskell.org/package/random-1.1/docs/System-Random.html

import qualified System.Random as Sr

demo :: IO ()
demo = do
  let g = Sr.mkStdGen 21
  let (num, g') = Sr.next g
  print num