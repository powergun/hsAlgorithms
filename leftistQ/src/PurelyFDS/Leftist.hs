module PurelyFDS.Leftist where
import           Data.Bool (bool)
import           Prelude   hiding (elem)
data Heap a = Leaf
            | Node {r :: Int, elem :: a, left :: Heap a, right :: Heap a}
            deriving (Eq, Ord, Show)

{-
 0   3
1 2 4 5

   0
1     2
     3
    4 5
mergeT (0) (3)
makeT 0 (1) (mergeT (2) (3))
  mergeT (2) (3)
  makeT 2 Leaf (mergeT Leaf (3))
    (3)
  makeT 2 Leaf (3)
  Node (0 + 1) 2 (3) Leaf
  (2)'
makeT 0 (1) (2)'
Node (1 + 1) 0 (1) (2)'
Node 2 0 (1) (2)'
-}
mergeT :: (Eq a, Ord a) => Heap a -> Heap a -> Heap a
mergeT Leaf n    = n
mergeT n    Leaf = n
mergeT n1   n2   = bool doRight doLeft (elem n1 <= elem n2)
  where
    doLeft  = makeT (elem n1) (left n1) (mergeT (right n1) n2)
    doRight = makeT (elem n2) (left n2) (mergeT n1 (right n2))
    rank :: Heap a -> Int
    rank Leaf = 0
    rank n    = r n
    makeT :: (Eq a, Ord a) => a -> Heap a -> Heap a -> Heap a
    makeT x n1 n2 =
      if rank n1 >= rank n2
        then Node (rank n2 + 1) x n1 n2
        else Node (rank n1 + 1) x n2 n1

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
