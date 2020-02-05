module PurelyFDS.WeightBiased where

import           Data.Bool (bool)
import           Prelude   hiding (elem)

data Heap a = Leaf
            | Node {sz :: Int, elem :: a, left :: Heap a, right :: Heap a}
            deriving (Eq, Ord, Show)

mergeT :: (Eq a, Ord a) => Heap a -> Heap a -> Heap a
mergeT Leaf n    = n
mergeT n    Leaf = n
mergeT n1   n2   = bool doRight doLeft (elem n1 <= elem n2)
  where
    doLeft  = makeT (elem n1) (left n1) (mergeT (right n1) n2)
    doRight = makeT (elem n2) (left n2) (mergeT n1 (right n2))
    sizeOf :: Heap a -> Int
    sizeOf Leaf = 0
    sizeOf n    = sz n
    makeT :: (Eq a, Ord a) => a -> Heap a -> Heap a -> Heap a
    makeT x n1 n2 =
      if sizeOf n1 >= sizeOf n2
        then Node (sizeOf n1 + sizeOf n2 + 1) x n1 n2
        else Node (sizeOf n1 + sizeOf n2 + 1) x n2 n1

insert :: (Eq a, Ord a) => a -> Heap a -> Heap a
insert x n = mergeT (Node 1 x Leaf Leaf) n

fromList :: (Eq a, Ord a) => [a] -> Heap a
fromList []     = Leaf
fromList (x:xs) = foldr insert (Node 1 x Leaf Leaf) xs

pop :: (Eq a, Ord a) => Heap a -> Maybe (a, Heap a)
pop Leaf           = Nothing
pop (Node _ x l r) = Just (x, mergeT l r)

sort :: (Eq a, Ord a) => [a] -> [a]
sort xs =
  let n = fromList xs
      toList Leaf = []
      toList n = case pop n of
                   Just (x, n') -> x : toList n'
                   Nothing      -> []
  in toList n
