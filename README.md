# cleanslate

Interactive data analysis in R can result in a messy environment with many temporary environment.
We may want to remove most of the variables except a few, e.g., the main data table.
This package provides convenient functions to keep some variables persisting in a different environment and remove others.

## Installation

```
devtools::install_github("chatchavan/cleanslate")
```

## Usage

Load the library.

```r
library(cleanslate)
```

Suppose you have the following analysis environment.

To keep a variable, use `persist()`:

```r
x <- "I want to keep"
persist(x)
```

`x` is now __moved__ from the interactive environment (`.GlobalEnv`) to a special environment created by this package. You can still access `x`, but `rm(x)` won't work.

If you have many other variables, there's also a function `rm_all()` to remove everything.

```r
y <- 12
z <- 13
rm_all()

y # Error: object 'y' not found
x # [1] "I want to keep"
```

Note that if you define a new variable with the same name as the `persist`ed variable, the new variable will mask the persisted one until it is removed.

```r
x <- 12
x # 12

rm(x)
x # [1] "I want to keep"
```

This pattern is intended for temporary modification of global variables until it is not used.

Restarting R will also clear persisted variables.