main :: IO ()
main = do
    let a = foldr (&&) True $ fmap ($ 3) [(>4), (>1), (>2)]  -- list can be long and consist of expensive computation

-- given an input - an integer 3 in this case - and a list of predicates, 
-- apply each predicate function to the input and fold the results
    putStrLn . show $ a

