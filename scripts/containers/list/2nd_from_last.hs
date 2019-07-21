#!/usr/bin/env stack runghc

import           Helpers (forM_, verify)

-- source
-- https://wiki.haskell.org/99_questions/Solutions/2

secondLast1 (x:y:rest) = Just ((last . init) (x:y:rest))
secondLast1 _          = Nothing

secondLast2 (x:y:rest) = Just ((reverse (x:y:rest)) !! 1)
secondLast2 _          = Nothing

secondLast3 (x:y:[])   = Just x
secondLast3 (x:y:rest) = secondLast3 (y:rest)
secondLast3 _          = Nothing

secondLast4 (x:y:rest) = Just $ (head . tail . reverse) (x:y:rest)
secondLast4 _          = Nothing

-- the initial (x, x) is "unreachable" - it has no effect to the
-- algorithm as long as the list has two or more elements
-- (_, _) elem -> (_, elem) next -> ...
-- ... (_, last') last -> (last', last)
secondLast5 (x:y:rest) = Just (fst pair)
                         where pair = foldl (\(a, b) x -> (b, x)) (x, x) (x:y:rest)
secondLast5 _          = Nothing

secondLast6 (x:y:rest) = case (length rest > 0) of
                            False -> Just x
                            True  -> secondLast6 (y:rest)
secondLast6 _ = Nothing

secondLast7 (x:y:rest) | length rest == 0 = Just x
                       | length rest >  0 = secondLast7 (y:rest)
secondLast7 _ = Nothing

main = do
  let condidates = [ ([], Nothing)
                   , ([1], Nothing)
                   , ([1..9], Just 8) ]
  forM_ [ secondLast1
        , secondLast2
        , secondLast3
        , secondLast4
        , secondLast5
        , secondLast6
        , secondLast7
        ] $ \f ->
    verify f condidates
