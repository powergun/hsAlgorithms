module Main where

import Lib

demoQueueCreation :: IO ()
demoQueueCreation = do
  print
    "//////// demo queue creation /////////////////////////////"
  let q = insertAllQ [3, 14, 1, 59, 2, 6, -535, 8, 97] (emptyQ)
      Just min_ = minimumQ q
      Just (q', min_') = popQ q
      Just (q'', min_'') = popNQ q 5
  print q
  print min_
  print $ min_ == min_'
  print $ minimumQ q'
  print min_''
  print q''

demoQueueCreationFoldl :: IO ()
demoQueueCreationFoldl = do
  print "//////// foldl q /////////////////////////////////////"
  -- MY NOTES:
  -- the example in the book uses foldr() (see the test directory)
  -- but using the flip() magic I can do it with foldl
  let q = foldl (flip insertQ) emptyQ [3, 14, 1, 59, 2, 6, -535, 8, 97]
  print q

main :: IO ()
main = do
  demoQueueCreation
  demoQueueCreationFoldl
