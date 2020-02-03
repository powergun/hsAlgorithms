module PurelyFDS.BST where

import           Data.Bool (bool)

data Tree a = Leaf
            | Node { l :: Tree a, value :: a, r :: Tree a }
            deriving (Eq, Ord, Show)

member' :: (Ord a, Eq a) => a -> Tree a -> Bool
member' _ Leaf         = False
member' v (Node l x r) = v == x || member' v l || member' v r

insert' :: (Ord a, Eq a) => a -> Tree a -> Tree a
insert' v Leaf = Node Leaf v Leaf
insert' v n@(Node l x r) =
  bool (n {l = insert' v l}) (n {r = insert' v r}) (v > x)

fromList' :: (Ord a, Eq a) => [a] -> Tree a
fromList' []     = Leaf
fromList' (x:xs) = foldr insert' (Node Leaf x Leaf) xs

preorder' :: Tree a -> [a]
preorder' Leaf         = []
preorder' (Node l x r) = preorder' l ++ [x] ++ preorder' r

sort' :: (Ord a, Eq a) => [a] -> [a]
sort' = preorder' . fromList'
