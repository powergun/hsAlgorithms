module PurelyFDS.RBTree where

import           Data.Bool (bool)
import           Prelude   hiding (elem)

data Color = Red
           | Black
-- All empty nodes are considered to be black, so the empty
-- constructor E does not need a color field
data Tree a = Leaf
            | Node { color :: Color
                   , left  :: Tree a
                   , elem  :: a
                   , right :: Tree a
                   }

insert :: (Eq a, Ord a) => a -> Tree a -> Tree a
insert x Leaf = Node Black (Leaf :: Tree a) x (Leaf :: Tree a)
insert x tree@(Node color left v right) =
  let doLeft = balance color (insert x left) v right
      doRight = balance color left v (insert x right)
  in bool (bool doRight doLeft (x < v)) tree (x == v)

balance :: (Eq a, Ord a) => Color -> Tree a -> a -> Tree a -> Tree a
{- recall the concept of "rotation", the pivot here is r-y
        B-z
    r-y      d
  r-x   c
a     b
       r-y
  B-x       B-z
a     b   c     d
-}
balance Black (Node Red (Node Red a x b) y c) z d =
  Node Red (Node Black a x b) y (Node Black c z d)
{-
         B-z
    r-x       d
  a    r-y
     b     c
-}
balance Black (Node Red a x (Node Red b y c)) z d =
  Node Red (Node Black a x b) y (Node Black c z d)
{-
       B-x
    a      r-z
        r-y    d
      b     c
-}
balance Black a x (Node Red (Node Red b y c) z d) =
  Node Red (Node Black a x b) y (Node Black c z d)
{-
       B-x
    a      r-y
         b     r-z
             c     d
-}
balance Black a x (Node Red b y (Node Red c z d)) =
  Node Red (Node Black a x b) y (Node Black c z d)
-- already balanced
balance color l x r = Node color l x r

fromList :: (Ord a, Eq a) => [a] -> Tree a
fromList []     = Leaf
fromList (x:xs) = foldr insert (Node Black Leaf x Leaf) xs

preorder :: (Ord a, Eq a) => Tree a -> [a]
preorder Leaf           = []
preorder (Node _ l x r) = preorder l ++ [x] ++ preorder r

sort :: (Ord a, Eq a) => [a] -> [a]
sort = preorder . fromList
