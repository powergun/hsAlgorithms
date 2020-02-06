# Binary Tree

## Purely Functional Data Structures: Binary Search Tree

## Purely Functional Data Structure: Red Black Tree

P/34

> BST performs very poorly on ordered data, for which any individual
> operation might take up to O(n) time

this can be observed in `bench/Main.hs`, `sortBenchOrderedData`

> The solution to this problem is to keep each tree approximately balanced.
> Then no individual operation takes more than O(log n) time.
> Red-black trees are one of the most popular families of balanced binary search trees.

P/35

the invariants of RB tree

> We insist that every red-black tree satisfy the following two balance invariants
> Invariant 1. No red node has a red child.
> Invariant 2. Every path from the root to an empty node contains the same number of black nodes.
> Taken together, these two invariants guarantee that the longest
> possible path in a red-black tree, **one with alternating black and
> red nodes, is no more than twice as long as the shortest possible
> path, one with black nodes only.**

Exercise 3.8

see: <https://github.com/rst76/pfds/blob/master/ch03/ex.3.8.md>

using the guarantee of the two invariants: `max_depth <= 2 * min_depth`;
because: `2^min_depth - 1 <= n` (think about the complete-balance tree);
therefore `min_depth <= log(n + 1)`;
plug in the previous property:
`max_depth <= 2 * min_depth => max_depth <= 2 * log(n + 1)`

the balance function:

P/36

> the balance function acts just like the T constructor except that
> it massages its arguments as necessary to enforce the balance
> invariants.

repair red-red violation

> The balance function detects and repairs each red-red violation
> when it processes the black parent of the red node with a red child.
