#!/usr/bin/env stack runghc

-- programming haskell L1988
-- insert into an ordered list

insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y    = x : y :ys
                | otherwise = y : insert x ys
demoInsert :: IO ()
demoInsert = do
    print "demo insert-into-ordered"
    print $ insert 4 [1, 2, 3, 4, 5, 6]

main :: IO ()
main = do
    demoInsert
