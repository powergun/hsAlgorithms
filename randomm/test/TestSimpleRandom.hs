module TestSimpleRandom (demo) where

import qualified SimpleRandom.Impl as Sut

demo :: IO ()
demo = do
  Sut.demo