import qualified BinomialSpec
import qualified LeftistSpec
import qualified LibCheck
import qualified LibDemo
import qualified PairingHeapsSpec
import qualified SplayTreeSpec
import qualified WeightBiasedSpec

main :: IO ()
main = do
  LibDemo.demo
  LibCheck.main
  LeftistSpec.spec
  WeightBiasedSpec.spec
  BinomialSpec.spec
  SplayTreeSpec.spec
  PairingHeapsSpec.spec

