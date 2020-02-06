module PurelyFDS.Stream where

import           Prelude hiding ((++))

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
  (CONS a s) >>= f = f a ++ (s >>= f)
