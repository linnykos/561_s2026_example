# Simulate a mixture of Spherical Gaussians

Simulate a mixture of Spherical Gaussians

## Usage

``` r
generate_mixture_gaussians(n, means, covariances, proportions)
```

## Arguments

- n:

  number of samples

- means:

  a matrix with `p` columns and `k` rows (for the number of clusters),
  where each row represents the mean of a Spherical Gaussian

- covariances:

  a list of `k` `p` positive definite matrices

- proportions:

  a non-negative vector of length `k` that sums to 1, where each value
  denotes the relative proportion of each cluster

## Value

a `n` by `p` matrix, where `n` is the number of samples and `p` is the
number of features

## Examples

``` r
n <- 500
means <- matrix(c(0, 0, 5, 5), ncol = 2, byrow = TRUE)
covariances <- list(diag(2),
                    diag(2))
proportions <- c(0.5, 0.5)
data <- generate_mixture_gaussians(n, means, covariances, proportions)
head(data)
#>            [,1]       [,2]
#> [1,]  5.6693782  6.4887322
#> [2,]  0.5025622 -0.1164599
#> [3,]  5.1609689  4.8101607
#> [4,]  3.4927390  3.9106904
#> [5,] -0.9871484 -1.7914358
#> [6,]  5.1216938  5.3710895
```
