# Haskell Containers

## Rediscover containers, First Principles

P/1133

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
