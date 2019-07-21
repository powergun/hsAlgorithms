#!/usr/bin/env stack runghc

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

verify :: ([Int] -> Maybe Int) -> IO ()
verify f = do
  assert Nothing $ f ([] :: [Int])
  assert Nothing $ f [111]
  assert (Just 5) $ f [1..6]
  where
    assert lhs rhs =
      case (lhs == rhs) of
        True  -> return ()
        False -> error $ "fail: " ++ show lhs ++ " != " ++ show rhs

main = do
  verify secondLast1
  verify secondLast2
  verify secondLast3
  verify secondLast4
  verify secondLast5
  verify secondLast6
  verify secondLast7
