module PurelyFDS.Stream where

import           Control.Monad (join)
import           Data.Bool     (bool)
import           Prelude       hiding (reverse, (++))

data Stream a = NIL
              | CONS a (Stream a)

(++) :: Stream a -> Stream a -> Stream a
(++) NIL s         = s
(++) (CONS x xs) s = CONS x (xs ++ s)

fromList :: [a] -> Stream a
fromList = foldr (\n s -> (CONS n NIL) ++ s) NIL

toList :: Stream a -> [a]
toList NIL         = []
toList (CONS x xs) = x : toList xs

instance Functor Stream where
  fmap f NIL        = NIL
  fmap f (CONS a s) = CONS (f a) (fmap f s)

instance Applicative Stream where
  pure x = CONS x NIL
  NIL <*> _ = NIL
  (CONS f s) <*> NIL = NIL
  (CONS f s) <*> (CONS a s') = CONS (f a) (s <*> s')

instance Monad Stream where
  return = pure
  NIL >>= f = NIL
  x@(CONS a s) >>= f = f a ++ (s >>= f)
    -- join $ fmap f x
    -- this does not work...

reverse :: Stream a -> Stream a
reverse NIL        = NIL
-- this works
-- reverse (CONS x s) = reverse s ++ CONS x NIL

-- this is taken from Purely Functional
-- P/45
reverse s =
  let rev NIL r        = r
      rev (CONS x s) r = rev s (CONS x r)
  in rev s NIL

instance Foldable Stream where
  foldr f z NIL        = z
  foldr f z (CONS x s) = f x (foldr f z s)

mergeOrd :: (Ord a, Eq a) => Stream a -> Stream a -> Stream a
mergeOrd NIL s = s
mergeOrd s NIL = s
mergeOrd s1@(CONS x xs) s2@(CONS y ys) =
  bool (CONS y (mergeOrd s1 ys)) (CONS x (mergeOrd xs s2)) (x < y)
