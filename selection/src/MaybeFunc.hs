module MaybeFunc (demo) where

import qualified Data.Maybe as Mb

demoPredefinedMaybeValue :: IO ()
demoPredefinedMaybeValue = do
  Mb.maybe handleFailure handleSuccess nay
  Mb.maybe handleFailure handleSuccess aye
  where
    aye :: Maybe Int
    aye = Just 68
    nay :: Maybe Int
    nay = Nothing
    handleFailure = print "Nothing(failed)"
    handleSuccess :: Int -> IO ()
    handleSuccess e = print $ "Just(succeeded): " ++ show e

demo :: IO ()
demo = do
  demoPredefinedMaybeValue
