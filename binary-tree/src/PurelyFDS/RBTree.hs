module PurelyFDS.RBTree where

data Color = Red
           | Black
-- All empty nodes are considered to be black, so the empty
-- constructor E does not need a color field
data Tree a = Leaf
            | Node Color (Tree a) a (Tree a)
