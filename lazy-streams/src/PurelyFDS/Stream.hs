module PurelyFDS.Stream where

import           Control.Monad (join)
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
  x@(CONS a s) >>= f = join $ fmap f x --f a `mappend` (s >>= f)

reverse :: Stream a -> Stream a
reverse NIL        = NIL
reverse (CONS x s) = reverse s ++ CONS x NIL

instance Foldable Stream where
  foldr f z NIL        = z
  foldr f z (CONS x s) = f x (foldr f z s)
