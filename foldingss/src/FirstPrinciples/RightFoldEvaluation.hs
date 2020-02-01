module FirstPrinciples.RightFoldEvaluation (demo) where

demoFoldrEvaluation :: IO ()
demoFoldrEvaluation = do
  let xs = fmap show [1..5]
  print $ foldr (\x y -> concat ["(" , x , "+" , y ,")"]) "0" xs

demo :: IO ()
demo = do
  print "//// foldr evaluation breakdown"
  demoFoldrEvaluation
