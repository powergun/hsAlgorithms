#!/usr/bin/env stack runghc

-- bucketize

module Main where

bucketize :: Int -> [a] -> [[a]]
bucketize n xs = 
  take n xs : bucketize n (drop n xs)

demoBucketize :: IO ()
demoBucketize = do
  print "//// demo bucketize"
  print $ take 5 $ bucketize 5 [0..]

-- see also real world haskell P/327, chunking a list
-- NOTE chunking function is based on splitAt:
-- https://hoogle.haskell.org/?hoogle=splitAt
-- splitAt n xs returns a tuple where first element is xs prefix 
-- of length n and second element is the remainder of the list
chunkWith :: ([a] -> ([a], [a])) -> [a] -> [[a]]
chunkWith _ [] = []
chunkWith f xs = 
  let (h, t) = f xs
  in h : chunkWith f t

chunksOf :: Int -> [a] -> [[a]]
chunksOf n =
  chunkWith (splitAt n)

demoChunking :: IO ()
demoChunking = do
  print $ take 5 $ chunksOf 5 [0..]

main :: IO ()
main = do
  demoBucketize
  demoChunking
