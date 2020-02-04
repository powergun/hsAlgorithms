module PurelyFDS.Leftist where
import           Data.Bool                      ( bool )
import           Prelude                 hiding ( elem )
data Heap a = Leaf | Node {rank :: Int, elem :: a, l :: Heap a, r :: Heap a}
              deriving (Eq, Ord, Show)

mergeT :: (Eq a, Ord a) => Heap a -> Heap a -> Heap a
mergeT Leaf n    = n
mergeT n    Leaf = n
mergeT n1   n2   = bool doLeft doRight (elem n1 <= elem n2)
   where
      doLeft  = makeT (elem n1) (l n1) (mergeT (r n1) n2)
      doRight = makeT (elem n2) (l n2) (mergeT n1 (r n2))
      rank' Leaf           = 0
      rank' (Node r _ _ _) = r
      makeT x n1 n2 = undefined
