module PurelyStreamSpec (spec) where

import           Test.Hspec

import qualified PurelyFDS.Stream as Stream

spec :: IO ()
spec = hspec $ do
  describe "Simple Lazy Stream" $ do
    it "fromList -> toList roundtrip" $ do
      let l = [1..100]
      (Stream.toList . Stream.fromList $ l) `shouldBe` l

  describe "Stream Functor, Applicative and Monad" $ do
    let l = [1..10]
        f = (+ 1)
        mf = return . (+ 1)
        fs = Stream.fromList $ replicate 10 f
    it "Functor" $ do
      Stream.toList (fmap f (Stream.fromList l)) `shouldBe` fmap f l

    it "Applicative" $ do
      Stream.toList (fs <*> (Stream.fromList l)) `shouldBe` fmap f l

    it "Monad" $ do
      Stream.toList ((Stream.fromList l) >>= mf) `shouldBe` fmap f l
