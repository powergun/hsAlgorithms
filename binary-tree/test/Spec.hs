import qualified PurelyBSTSpec
import qualified PurelyRBTreeSpec

main :: IO ()
main = do
  PurelyBSTSpec.spec
  PurelyRBTreeSpec.spec
