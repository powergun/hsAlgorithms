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

## High Perf Haskell: Meet Lazy Eval P/34

for the explanation of `seq`, see also: hsFP/lazinesss (First Principles)

how to witness lazy eval in ghci - note how `a` is partially evaluated
up to the element at index 10

```haskell
hs> let a = enumFromTo 1 100 :: [Int]
hs> :sprint a
a = _
hs> a !! 10
11
hs> :sprint a
a = 1 : 2 : 3 : 4 : 5 : 6 : 7 : 8 : 9 : 10 : 11 : _
```

NOTE: a is `[Num]` not `[Int]` due to ad hoc polymorphism;
with type annotation `sprint` **won't** display the above info

P/38

foldr and weak head normal form

```haskell
hs> a = foldr (+) 0 [1..100000]
hs> :sprint a
a = _
hs> a
5000050000
hs>
```

`foldr` returns a thunk
