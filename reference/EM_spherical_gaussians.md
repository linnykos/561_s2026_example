# EM algorithm for Spherical Gaussians

EM algorithm for Spherical Gaussians

## Usage

``` r
EM_spherical_gaussians(data, k, max.iter = 100, tol = 1e-06)
```

## Arguments

- data:

  `n` by `p` matrix, where `n` is the number of samples and `p` is the
  number of features

- k:

  number of clusters

- max.iter:

  maximum iteration of EM

- tol:

  relative change in log-likelihood. If the change is less than `tol`,
  then the method terminates early.

## Value

a list with elements `means`, `variances`, `proportions`, and
`log_likelihood` for all the respective estimated components of the
mixture of Spherical Gaussians

## Examples

``` r
n <- 500
means <- matrix(c(0, 0, 5, 5), ncol = 2, byrow = TRUE)
covariances <- list(diag(2),
                    diag(2))
proportions <- c(0.5, 0.5)
data <- generate_mixture_gaussians(n, means, covariances, proportions)

# Fit EM algorithm to the generated data
k <- 2 # Number of Gaussian components
em_results <- EM_spherical_gaussians(data, k)
em_results
#> $means
#>          [,1]     [,2]
#> [1,] 5.556755 5.488386
#> [2,] 1.530882 1.444681
#> 
#> $variances
#> [1] 0.5811481 5.5570134
#> 
#> $proportions
#> [1] 0.2305486 0.7694514
#> 
#> $log_likelihood
#> [1] -8.437695e-15
#> 
```
