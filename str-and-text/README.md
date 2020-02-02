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
