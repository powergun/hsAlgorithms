# Lazy Evaluation: Stream

## Purely Functional Data Structure: Lazy Stream (chapter 4)

P/44

see: `src/PurelyFDS/Stream.hs`;

Implement the Monad instance for Stream

see also: <http://hackage.haskell.org/package/stream-monad-0.4.0.2/docs/src/Control-Monad-Stream.html#Stream>

Note the above reference using `mplus` instead of `++` for threading
the effects

implementing the `Foldable` instance for Stream

see also: <http://hackage.haskell.org/package/base-4.12.0.0/docs/src/Data.Foldable.html#line-284>

Note that the reference does not use `mappend` nor `+` **but a simple
recursion** to implement **foldr**
