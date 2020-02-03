module PurelyFDS.Lists where

update' :: [a] -> Int -> a -> [a]
update' (x:xs) 0 y = (y:xs)
update' (x:xs) i y = x : (update' xs (i - 1) y)
update' [] _ _     = []
