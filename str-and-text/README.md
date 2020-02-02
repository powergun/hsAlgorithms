# String and Text

inspired by:
[a gentle introduction to monad transformers](https://github.com/kqr/gists/blob/master/articles/gentle-introduction-monad-transformers.md#implementing-instances-for-common-typeclasses)

String and Text has similar interfaces;

Text library is `text`

## Concatenation (append, join etc.)

how to concatenate two or more str/text

## Partition (split, unlines etc.)

## Text and String Memory Usage Comparison, First Principles P/1143

> However, Text is encoded as UTF-16, and that isn;t what most people
> expect given UTF-8's popularity.
> In Text's defense, UTF-16 is often faster due to cache friendliness via chunkier and more pre- dictable memory accesses.

see: `app/memory/profile.sh`; see also: `hsPerf/profiling101`

## Rediscover ByteString, First Principles P/1145

> The main benefit of ByteString is that it's easy to use via the
> OverloadedStrings pragma but is bytes instead of text.
> This addresses a larger problem space than mere text.
> The flip side of that, of course, is that it encompasses byte data that
> isn't comprehensible text. That's a drawback if you didn't mean to
> permit non-text byte sequences in your data.

see `src/FirstPrinciples/ByteStringZip.hs` to see when bytestring can
not be treated as a carrier of printable, `utf-*` encoded texts

### Use UTF-8 Encoding/Decoding Correctly

P/1147

see `src/FirstPrinciples/Utf8.hs`; observe how to:

- embed UTF-8 raw code points in the haskell source file
- decode UTF-8 raw code points to the printable characters
- dance between String, Text and ByteString
- use `ord` to get the UTF-16 code points
