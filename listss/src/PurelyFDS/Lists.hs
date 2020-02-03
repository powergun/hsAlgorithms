module PurelyFDS.Lists where

update' :: [a] -> Int -> a -> [a]
update' (x:xs) 0 y = (y:xs)
update' (x:xs) i y = x : (update' xs (i - 1) y)
update' [] _ _     = []

-- suffixes [1,2,3,4] = [[1,2,3,4], [2,3,4], [3,4], [4], [ ] ]
suffixes' :: [a] -> [[a]]
suffixes' []       = [[]]
suffixes' l@(_:xs) = l : (suffixes' xs)
