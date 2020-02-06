module PurelyStreamSpec (spec) where

import           Test.Hspec

import           Data.List        (sort)
import qualified PurelyFDS.Stream as Stream

spec :: IO ()
spec = hspec $ do
  describe "Simple Lazy Stream" $ do
    it "fromList -> toList roundtrip" $ do
      let l = [1..100]
      (Stream.toList . Stream.fromList $ l) `shouldBe` l

  describe "Expect Lazy evaluation" $ do
    it "comparison" $ do
      let s = Stream.fromList [1..1000000000000]
      Stream.toList s `shouldNotBe` [1]

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

  describe "Stream reversing" $ do
    let l = [1..10]

    it "compare to list.reverse" $ do
      let l' = Stream.toList . Stream.reverse . Stream.fromList $ l
      l' `shouldBe` reverse l

  describe "Stream sort" $ do
    let s1 = Stream.fromList [2..4]
        s2 = Stream.fromList [1..10]

    it "Merge two ordered Streams " $ do
      let s = Stream.mergeOrd s1 s2
      Stream.toList s `shouldBe` sort ([2..4] ++ [1..10])
