# Heaps

## in Haskell Cookbook

## in Purely Functional Data Structure P/27

(leftist heap is considered simple in both FP and imperative)

> Heaps are often implemented as heap-ordered trees, in which the element
> at each node is no larger than the elements at its children. Under this
> ordering, the minimum element in a tree is always at the root.

### Leftist, Right Spine and Leftist's Property

see: `src/PurelyFDS/Leftist.hs`

rank

> leftist property: the **rank** of any **left child** is at least as large
> as the rank of its right sibling.
> **The rank of a node is defined to be the length of its right spine** > **i.e., the rightmost path from the node in question to an empty node**

P/28 Exercise 3.1 Proof (see: <https://github.com/rst76/pfds/blob/master/ch03/ex.3.1.md>)

```text
       o
     o   o
    o o o o <- can not delete any of these
 .............
```

given the rank is D, size is N, the minimal size N = 2 ^ D - 1
because it is not possible to remove any leaf nodes without violating
the leftist law

what can this property do

> Note that the elements along the right spine of a leftist heap (in
> fact, along any path through a heap-ordered tree) are stored in
> sorted order.
> The key insight behind leftist heaps is that two heaps can be merged
> by merging their right spines as you would merge two sorted lists, and
> then swapping the children of nodes along this path as necessary to
> **restore the leftist property**.

### Weight-Biased Leftist Heap

P/30

> Weight-biased leftist heaps are an alternative to leftist heaps that
> replace the leftist property with the weight-biased leftist property:
> **the size of any left child is at least as large as the size of its right sibling.**

see: `src/PurelyFDS/WeightBiased.hs`

### Binomial Heaps

P/30

insert and merge can be run in O(1) time in various flavours of
binomial heaps

P/31

> A binomial tree of rank 0 is a singleton node.
> A binomial tree of rank r + 1 is formed by linking two binomial
> trees of rank r, making one tree the leftmost child of the other.
> From this definition, it is easy to see that a binomial **tree of
> rank r contains exactly 2^r nodes.**

Binomial tree's children order

> Each list of children is maintained in decreasing order of rank,
> and elements are stored in heap order. We maintain heap order by
> always linking trees with larger roots under trees with smaller roots.

Binomial heap is a collection of heap-ordered binomial trees

> a binomial heap is a collection of heap-ordered binomial trees in which
> **no two trees have the same rank**. This collection is represented as a list
> of trees **in increasing order of rank**

P/32

Binomal heap and binary representation of a decimal number

> Because each binomial tree contains 2^r elements and no two trees have
> the same rank, the trees in a binomial heap of size n correspond exactly
> to the ones in the binary representation of n.
> a binomial heap of size 21 (0b10101) would contain one tree of rank 0,
> one tree of rank 2, and one tree of rank 4
> a binary representation contains at most log(n) + 1 `1`s; therefore
> a binomal heap of size n contains at most log(n) + 1 binomal trees

P/32

worst case of insert() is log(n)

> The worst case is insertion into a heap of size n = 2^k — 1, requiring a
> total of k links and O(k) = O(log n) time.

P/33

implementing deleteMin (aka pop())

> After discarding the root of the extracted tree, we must somehow return
> the children of the discarded node to the remaining list of trees.
> Note that each list of children **is almost a valid binomial heap.**
> convert the list of children into a valid binomial heap by reversing
> it and then merge this list with the remaining trees.

### Splay Heap (Splay Tree)

P/56

see: `src/PurelyFDS/SplayTree.hs`;
reference: <https://en.wikipedia.org/wiki/Splay_tree>

> Splay trees are a close relative of balanced binary search trees,
> but they maintain no explicit balance information.
> Instead, every operation blindly restructures the tree using some
> simple transformations that tend to increase balance.
> Although any individual operation can take as much as O(n) time,
> we will show that every operation runs in O(log n) amortized time

major difference to balanced binary search tree

> A major difference between splay trees and balanced binary search
> trees such as the red-black trees is that splay trees are restructured
> even during queries (e.g., member) instead of only during updates
> (e.g., insert).
> (while splay tree is awkward for sets or infinite maps) A good example
> is the heap abstraction, where the only interesting query is findMin.
> In fact, as we will see, splay trees make an excellent implementation
> of heaps
