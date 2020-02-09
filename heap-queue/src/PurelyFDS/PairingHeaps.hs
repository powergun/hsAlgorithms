module PurelyFDS.PairingHeaps where

data Tree a = Leaf
            | Node a [Tree a]

merge :: (Eq a, Ord a) => Tree a -> Tree a -> Tree a
merge n Leaf = n
merge Leaf n = n
merge n1@(Node x hs1) n2@(Node y hs2) =
  if (x <= y)
    then Node x (n2:hs1)
    else Node y (n1:hs2)

insert :: (Eq a, Ord a) => a -> Tree a -> Tree a
insert x n = merge (Node x []) n

fromList :: (Eq a, Ord a) => [a] -> Tree a
fromList = foldr insert Leaf

mergePairs :: (Eq a, Ord a) => [Tree a] -> Tree a
mergePairs []         = Leaf
mergePairs [x]        = x
mergePairs (h1:h2:hs) = merge (merge h1 h2) (mergePairs hs)

findMin :: (Eq a, Ord a) => Tree a -> Maybe a
findMin Leaf       = Nothing
findMin (Node x _) = Just x
