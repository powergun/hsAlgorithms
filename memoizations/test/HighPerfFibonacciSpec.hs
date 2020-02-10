module HighPerfFibonacciSpec (spec) where

import           Test.Hspec

import qualified HighPerf.Fibonacci as Fib

spec = hspec $ do
  describe "Fibonacci using lookup" $ do
    it "Can deal with a large workload" $ do
      (Fib.fib_mem 10000) > 0 `shouldBe` True
