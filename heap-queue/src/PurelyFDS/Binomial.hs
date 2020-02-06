module PurelyFDS.Binomial where

import           Data.Bool (bool)
import           Prelude   hiding (elem)

data Tree a = Node {rank :: Int, elem :: a, children :: [Tree a]}
type Heap a = [Tree a]

link :: (Eq a, Ord a) => Tree a -> Tree a -> Tree a
link n1@(Node r1 e1 c1) n2@(Node r2 e2 c2)=
  bool (Node (r2 + 1) e2 (n1 : c2)) (Node (r1 + 1) e1 (n2 : c1)) (e1 <= e2)

insTree :: (Eq a, Ord a) => Tree a -> Heap a -> Heap a
insTree t []           = [t]
insTree t trees@(x:xs) =
  bool (insTree (link t x) xs) (t:trees) (rank t < rank x)
  --            ^^^^^^^^^^ t ceases to exist, becomes a new tree
  --                       no need to worry about mutability

insert :: (Eq a, Ord a) => a -> Heap a -> Heap a
insert x = insTree (Node 0 x [])

fromList :: (Eq a, Ord a) => [a] -> Heap a
fromList []     = []
fromList (x:xs) = foldr insert [Node 0 x []] xs

removeMinTree :: (Eq a, Ord a) => Heap a -> (Tree a, Heap a)
removeMinTree [x] = (x, [])
removeMinTree (x:xs) =
  let (t, trees) = removeMinTree xs
  in bool (t, x:trees) (x, xs) (elem x <= elem t)

findMin :: (Eq a, Ord a) => Heap a -> Maybe a
findMin [] = Nothing
findMin hp =
  let (t, _) = removeMinTree hp
  in Just . elem $ t

merge :: (Eq a, Ord a) => Heap a -> Heap a -> Heap a
merge hp []             = hp
merge [] hp             = hp
merge hp1@(t1:ts1) hp2@(t2:ts2) =
  if rank t1 < rank t2
    then t1 : merge ts1 hp2
    else
      if rank t1 > rank t2
        then t2 : merge hp1 ts2
        else
          insTree (link t1 t2) (merge ts1 ts2)
