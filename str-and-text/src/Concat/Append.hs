{-# LANGUAGE OverloadedStrings #-}

module Concat.Append (demo) where

import qualified Data.Text as T

demoStr :: IO ()
demoStr = do
  print $ (++) "Domain: " "macgnw.com"

demoText :: IO ()
demoText = do
  print $ T.append "Domain: " "macgnw.com"

demo :: IO ()
demo = demoStr >> demoText
