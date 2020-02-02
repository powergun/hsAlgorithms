# Queue

## Discover Double-Ended Queue (Deque), First Principles

P/1152, mentioning that, this data structure comes from
From Okasaki's Purely Functional Data Structures

NOTE: I made a mistake in the impl `FromScratchDeque.hs` - this is
exactly the bad example First Principles wants to demonstrate:
excessively using reverse to achieve the push-pop order;

I fixed this in `CorrectDeque.hs` and created a benchmark driver

`stack bench` - the good impl (94.14 μs) is 100x faster than the
navie impl (153.1 ms)
