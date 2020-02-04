import qualified LeftistSpec
import qualified LibCheck
import qualified LibDemo

main :: IO ()
main = do
  LibDemo.demo
  LibCheck.main
  LeftistSpec.spec
