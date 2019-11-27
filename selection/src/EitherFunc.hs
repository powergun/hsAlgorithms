module EitherFunc (demo) where

import qualified Data.Either as E

-- showing the basic feature of either() function using a set
-- of predetermined Either values
demoPredeterminedEitherValue :: IO ()
demoPredeterminedEitherValue = do
  E.either sayError sayValue nay
  E.either sayError sayValue aye
  where
    nay :: Either String Int
    nay = Left ".-._"
    aye :: Either String Int
    aye = Right 58
    sayError :: String -> IO ()
    sayError err = print $ "Left(error): " ++ err
    sayValue :: Int -> IO ()
    sayValue v = print $ "Right(value): " ++ show v

demo :: IO ()
demo = do
  demoPredeterminedEitherValue
