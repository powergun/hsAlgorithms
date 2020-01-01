import qualified CryptohashOfficialTests
import qualified TestFromByteString

main :: IO ()
main = do
  TestFromByteString.demo
  CryptohashOfficialTests.main
