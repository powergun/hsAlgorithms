#!/usr/bin/env stack runghc

-- haskell cookbook L3629

import qualified Data.Set as S

demoSetFold :: IO ()
demoSetFold = do
  print
    "//////// demo set folding ////////////////////////////////"
  let fromL = S.fromList ["there", "is", "a", "cow"]
  print $ S.foldr (:) [] fromL
  print $ S.foldl (flip (:)) [] fromL
                -- ^^^^^^^^ char:chars 
                -- (the original order is chars, char)

main :: IO ()
main = do
  let emptyS = S.empty :: S.Set String
      singleS = S.singleton "there"
      insS = S.insert "is" singleS
      fromL = S.fromList [0..9] :: S.Set Int
  print emptyS
  print singleS
  print (insS, S.size insS)
  print (S.fromList ["there", "is", "a", "cow"])
  print fromL
  print (S.toList fromL)
  print (S.toDescList fromL)
  print (S.toAscList $ S.fromList ["there", "is", "a", "cow"])
  print (S.deleteMin fromL)
  print (S.deleteMax fromL)
  print (S.intersection singleS insS)
  print (S.union singleS insS)
  print (S.lookupGT 5 fromL)
  print (S.lookupGE 5 fromL)
  print (S.member 4 fromL)

  -- MY NOTES: implement Python's set (-) operator
  print (S.intersection insS $ S.difference insS singleS)
  print (S.intersection singleS $ S.difference insS singleS)

  demoSetFold


