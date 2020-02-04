module PurelyFDS.BST where

import           Data.Bool (bool)

data Tree a = Leaf
            | Node { l :: Tree a, value :: a, r :: Tree a }
            deriving (Eq, Ord, Show)

member' :: (Ord a, Eq a) => a -> Tree a -> Bool
member' _ Leaf         = False
member' v (Node l x r) = v == x || member' v l || member' v r

member'' :: (Ord a, Eq a) => a -> Tree a -> Bool
member'' _ Leaf         = False
member'' v (Node l x r) = v == x
                        || (v <= x && member' v l)
                        || (v >  x && member' v r)

insert' :: (Ord a, Eq a) => a -> Tree a -> Tree a
insert' v Leaf = Node Leaf v Leaf
insert' v n@(Node l x r) =
  bool (n {l = insert' v l}) (n {r = insert' v r}) (v > x)

-- performance is EVEN WORSE!!!
-- copied from: https://github.com/rst76/pfds/blob/master/ch02/ex.2.3.1.hs
insert'' :: Ord a => a -> Tree a -> Tree a
insert'' x tree = doInsert id tree
  where
    doInsert k Leaf = k (Node Leaf x Leaf)
    doInsert k (Node left y right)
      | x > y = doInsert (\r -> k (Node left y r)) right
      | otherwise = doInsert (\l -> k (Node l y right)) left

fromList' :: (Ord a, Eq a) => [a] -> Tree a
fromList' []     = Leaf
fromList' (x:xs) = foldr insert' (Node Leaf x Leaf) xs

preorder' :: Tree a -> [a]
preorder' Leaf         = []
preorder' (Node l x r) = preorder' l ++ [x] ++ preorder' r

sort' :: (Ord a, Eq a) => [a] -> [a]
sort' = preorder' . fromList'
