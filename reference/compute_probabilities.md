# Compute the probabilites after EM

Specifically, compute the probabilities of each sample originating from
the Spherical Gaussian (after running `EM_spherical_gaussians`)

## Usage

``` r
compute_probabilities(data, means, variances, proportions)
```

## Arguments

- data:

  `n` by `p` matrix, where `n` is the number of samples and `p` is the
  number of features

- means:

  a matrix with `p` columns and `k` rows (for the number of clusters),
  where each row represents the mean of a Spherical Gaussian

- variances:

  a non-negative vector of length `k`, where each value denotes the
  variance of the Spherical Gaussian

- proportions:

  a non-negative vector of length `k` that sums to 1, where each value
  denotes the relative proportion of each cluster

## Value

a matrix of `n` by `k`, where each row denotes the probability that each
sample was drawn from that cluster. Each row sums to 1 and is
non-negative

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
means_estimated <- em_results$means
variances_estimated <- em_results$variances
proportions_estimated <- em_results$proportions

# Compute the probabilities for each sample
probabilities <- compute_probabilities(data = data,
                                       means = means_estimated,
                                       variances = variances_estimated,
                                       proportions = proportions_estimated)
head(probabilities)
#>              [,1]         [,2]
#> [1,] 0.0007929579 9.992070e-01
#> [2,] 0.0008513876 9.991486e-01
#> [3,] 0.0100109229 9.899891e-01
#> [4,] 1.0000000000 7.292808e-12
#> [5,] 0.0016568955 9.983431e-01
#> [6,] 0.0059486200 9.940514e-01
```
