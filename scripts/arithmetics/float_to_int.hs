#!/usr/bin/env stack runghc

demoFloatToInt :: IO ()
demoFloatToInt = do
  print "//// demo convert float to int"
  print [truncate 3.55, floor 3.55, round 3.55]

main :: IO ()
main =
  demoFloatToInt
