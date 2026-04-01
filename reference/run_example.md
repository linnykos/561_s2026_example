# Simulate an example

Simulate an example

## Usage

``` r
run_example(n = 5000)
```

## Arguments

- n:

  number of samples

## Value

a list containing `data` (the dataset generated), `em_results` (the
output of `EM_spherical_gaussians`), and `probabilities` (the output of
`compute_probabilities`)

This program uses the following functions: `generate_mixture_gaussians`,
`EM_spherical_gaussians`, and `compute_probabilities`.

## See also

[`generate_mixture_gaussians()`](https://linnykos.github.io/561_s2026_example/reference/generate_mixture_gaussians.md),
[`EM_spherical_gaussians()`](https://linnykos.github.io/561_s2026_example/reference/EM_spherical_gaussians.md),
and
[`compute_probabilities()`](https://linnykos.github.io/561_s2026_example/reference/compute_probabilities.md)

## Examples

``` r
res <- run_example()
res$em_results
#> $means
#>              [,1]        [,2]
#> [1,]  2.000675688  1.98424467
#> [2,] -0.002657805 -0.03816044
#> [3,]  5.047867139  4.97657474
#> 
#> $variances
#> [1] 0.1244912 0.9799054 1.4883660
#> 
#> $proportions
#> [1] 0.4050738 0.2035087 0.3914176
#> 
#> $log_likelihood
#> [1] -1.376677e-14
#> 
```
