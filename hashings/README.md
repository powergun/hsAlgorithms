# Hash Stuffs

inspired and needed by hsCrypto project, which (blockchain subproject)
uses <http://hackage.haskell.org/package/cryptohash>

IMPORTANT: cryptohash package is **deprecated** in favor of **cryptonite**;
the official tests/examples from cryptohash can not compile

## Create hash from bytestring

see: FromByteString.hs and tests

also showing how to pack a list of Word8 values and create a SHA1 hash
using the API
