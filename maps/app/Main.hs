import System.IO
import qualified Data.Map.Strict as M
import System.Environment
import Control.Monad
import Data.List.Split

getLines :: Handle -> IO [String]
getLines h = do
  isEOF <- hIsEOF h
  if isEOF then
    return []
  else
    (:) <$> hGetLine h <*> getLines h

parseLog :: Handle -> IO ()
parseLog h = do
  callCountMap <- fmap buildCallCountMap (extractAllProgramNames h)
  let callCountList = M.toAscList callCountMap
  forM_ callCountList $ \(programName, count) -> do
    if programName == ""
    then
      putStr ""
    else
      print $ programName ++ " - " ++ (show count) 

extractProgramName :: [String] -> String
extractProgramName (_:_:_:_:p:_) =
  -- see http://hackage.haskell.org/package/split-0.2.3.3/docs/Data-List-Split.html
  -- require package "split"
  head $ splitOn ":" $ head $ splitOn "[" p
extractProgramName _ = "" 

extractAllProgramNames :: Handle -> IO [String]
extractAllProgramNames h =
  fmap (extractProgramName . words) <$> getLines h

updateCallCount :: String -> M.Map String Int -> M.Map String Int
updateCallCount programName callCountMap =
  M.insertWith (+) programName 1 callCountMap

buildCallCountMap :: [String] -> M.Map String Int
buildCallCountMap = 
  foldr updateCallCount M.empty

main :: IO ()
main = do
  withFile "ca_dev_bastion_syslog.txt" ReadMode parseLog
