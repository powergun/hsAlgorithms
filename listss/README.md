# List

## Purely Functional Data Structures P/20

> Although this is undeniably a lot of copying, notice that we did not
> have to copy the second list, ys. Instead, these nodes are shared between
> ys and zs. Another function that illustrates these twin concepts of copying
> and sharing is `update`, which changes the value of a node at a given index in the list.

see: `src/PurelyFDS/Lists.hs`; see also its performance comparison to `Vector`;

**NOTE** this `update` function's performance degrades as the size of the List
increases (and the further the indice goes toward to the end); on the contrary,
the performance of Vector's `//` is unaffected

**NOTE 2** I had to use `nf` to trigger complete evaluation.
