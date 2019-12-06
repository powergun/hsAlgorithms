{-# LANGUAGE OverloadedStrings #-}
module Partition.Split (demo) where

import           Data.List
import qualified Data.Text as T

demoStr :: IO ()
demoStr = do
  -- source:
  -- https://stackoverflow.com/questions/4978578/how-to-split-a-string-in-haskell
  -- roll a helper function like below or use the `split` package
  let wordsWhen     :: (Char -> Bool) -> String -> [String]
      wordsWhen p s =  case dropWhile p s of
                        "" -> []
                        s' -> w : wordsWhen p s''
                              where (w, s'') = break p s'
      splitOn c = wordsWhen (== c)
  print $ splitOn '@' ""
  print $ splitOn '@' "wei@gmail.com"

demoText :: IO ()
demoText = do
  print $ T.splitOn "@" ""
  print $ T.splitOn "@" "wei@gmail.com"

demo = demoStr >> demoText
