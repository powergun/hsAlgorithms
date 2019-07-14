#!/usr/bin/env stack runghc

-- haskell cookbook L3701
-- L3770
-- in a case where a different type class behavior is expected
-- than the implementation, a typical trick is to wrap the 
-- existing data type, for which type class instance is already
-- defined, in another type, and then define the type class 
-- instance for it instead

import qualified Data.Set as S

data Book = Book { isbn :: String
                 , title :: String
                 , author :: String }
                 deriving (Show)

instance Eq Book where
  book1 == book2 = (isbn book1) == (isbn book2)

instance Ord Book where
  book1 `compare` book2 = (isbn book1) `compare` (isbn book2)

data Item = Item Book Int deriving Show

instance Eq Item where
  (Item b1 _) == (Item b2 _) = b1 == b2

instance Ord Item where
  (Item b1 _) `compare` (Item b2 _) = b1 `compare` b2

type ShoppingCart = S.Set Item

emptyCart :: ShoppingCart
emptyCart = S.empty

updateItem :: Int -> Book -> ShoppingCart -> ShoppingCart
updateItem n book cart =
  let item = Item book 1
      search = S.lookupGE item cart
  in case search of
      Nothing -> S.insert item cart
      Just (Item b i) -> 
        if (isbn b) == (isbn book)
        then
          if (i + n) > 0
          then
            S.insert (Item b (i + n)) cart -- "override" existing item
          else
            S.delete (Item b i) cart
        else
          S.insert (Item book 1) cart

addBook = updateItem 1
removeBook = updateItem (-1)

demoShoppingCart :: IO ()
demoShoppingCart = do
  let book1 = Book { isbn = "0262162091"
                   , author = "Pierce, Benjamin C."
                   , title = "Types and Programming Languages" }
      book2 = Book { isbn = "8173715270"
                   , author = "Abelson, Herold et. al."
                   , title = "Structure and Interpretation of Computer Programs" }
      cart  = emptyCart
      cart1 = addBook book1 cart
      cart2 = addBook book2 cart1
      cart3 = addBook book1 cart2
      cart4 = addBook book1 cart3
      cart5 = removeBook book1 cart4
      cart6 = removeBook book2 cart5
  print cart
  print cart1
  print cart2
  print cart3
  print cart4
  print cart5
  print cart6

main :: IO ()
main = do
  demoShoppingCart
