#!/usr/bin/env stack runghc

-- programming haskell L2397
-- foldr: fold right
-- recall foldl (fold left)

demoFoldr :: IO ()
demoFoldr = do
    print "//// demo foldr"
    -- lambda with 2 arguments
    -- https://stackoverflow.com/questions/31301307/haskell-anonymous-function-with-two-arguments
    -- foldr: the value goes last
    -- 1 + (2 + (3+ 0))
    print $ foldr (\aggr elem -> aggr ++ elem) ":" ["there", "is", "acow"]

-- foldl is tail recursion - the function call is last thing to 
-- execute
-- see
-- https://wiki.haskell.org/Tail_recursion
-- https://wiki.haskell.org/Fold
demoFoldl :: IO ()
demoFoldl = do
    print "//// demo foldl"
    -- ((0+1)+2)+3
    print $ foldl (\aggr elem -> aggr ++ elem) ":" ["there", "is", "acow"] 

main :: IO ()
main = do
    demoFoldr
    demoFoldl

    print $ foldr (+) 0 [3, 1, 4]
