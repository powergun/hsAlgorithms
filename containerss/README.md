# Haskell Containers

## Rediscover containers, First Principles

### Profiling

P/1120

see also `hsPerf` project

### Vector

First Principles P/1133

> "Boxed" means the vector can reference any datatype you want;
> "unboxed" represents raw values without pointer indirection
> "Slicing" refers to slicing off a portion, or creating a sub-array.
> The Vector type is designed for making slicing much cheaper than it otherwise would be.

Vector slicing is performant:

> What makes Vector nicer than lists and Array in this respect is that
> when you construct a slice or "view" of another Vector, it doesn’t
> have to construct as much new data.
> It returns a new wrapper around the original underlying array with a
> new index and offset with a reference to the same original Array.

Recall the immutable-ref idiom in Rust.

What is fusion P/1137

> The vector library has loop fusion built in, so in a lot of cases,
> such as with mapping, you won’t construct 4 vectors just because you mapped four times.

#### ST monad

P/1140

> ST can be thought of as a mutable variant of the strict State monad
> From another angle, it could be thought of as IO restricted exclusively
> to mutation which is guaranteed safe.

see: `src/FirstPrinciples/VectorMutable.hs`

> The added time in the ST version is from freezing the mutable vector
> into an ordinary vector.
> it can be handy when you want to temporarily make something mutable and
> ensure no mutable references are exposed outside of the ST monad.

P/1141

> For ST to work properly, the code that mutates the data must not get
> reordered by the optimizer or otherwise monkeyed with, much like the
> code in IO

what is the mutation

> It’s important to understand that s isn't the state you’re mutating.
> The mutation is a side effect of having entered the closures that
> perform the effect. This strict, unlifted state transformer monad
> happens to structure your code in a way that preserves the intended
> order of the computations and their associated effects.
