#!/usr/bin/env stack runghc

-- |filter is one of the standard high order functions
demoFilterWithBuiltinOperator :: IO ()
demoFilterWithBuiltinOperator = do
  print "//// demo filter with builtin operator"
  print $ filter (> 3) [1, 2, 3, 4, 5, 6, 7, 8]

demoFilterWithLambda :: IO ()
demoFilterWithLambda = do
  print "//// demo filter with lambda"
  print $ filter (\n -> n > 3) [0..6]
  print $ filter (\l -> (l !! 0) == '#')
    ["#id", "idd", "idfa", "#  idkfa"]
  print $ filter (\l -> (length l > 0) && (l !! 0) == '#')
    ["#id", "idd", "idfa", "#  idkfa", ""]
  print $ filter (\l -> (length l > 0) && (l !! 0) /= '#')
    ["#id", "idd", "idfa", "#  idkfa", ""]

main :: IO ()
main = do
  demoFilterWithBuiltinOperator
  demoFilterWithLambda
