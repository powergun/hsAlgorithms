module PurelyFDS.SplayTree where

import           Data.Bool (bool)

data Tree a = Leaf
            | Node (Tree a) a (Tree a)
            deriving (Show)

partition :: (Eq a, Ord a) =>
             a -> Tree a -> (Tree a, Tree a)
partition pivot Leaf = (Leaf, Leaf)
partition pivot n@(Node a x b) =
  bool doLeft doRight (x <= pivot)
  where
    doRight =
      case b of
        Leaf         -> (n, Leaf)
        Node b1 y b2 ->
          if (y <= pivot)
            then let (small, big) = partition pivot b2
                 in (Node (Node a x b1) y small, big)
            else let (small, big) = partition pivot b1
                 in (Node a x small, Node big y b2)
    doLeft =
      case a of
        Leaf         -> (Leaf, n)
        Node a1 y a2 ->
          if (y <= pivot)
            then let (small, big) = partition pivot a2
                 in (Node a1 y small, Node big x b)
            else let (small, big) = partition pivot a1
                 in (small, Node big y (Node a2 x b))

insert :: (Ord a, Eq a) => a -> Tree a -> Tree a
insert x n = let (small, big) = partition x n
             in Node small x big

fromList :: (Ord a, Eq a) => [a] -> Tree a
fromList = foldr insert Leaf

findMin :: (Ord a, Eq a) => Tree a -> Maybe a
findMin Leaf            = Nothing
findMin (Node Leaf x _) = Just x
findMin (Node a x b)    = findMin a
