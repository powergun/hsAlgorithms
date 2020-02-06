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
