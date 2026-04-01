context("Testing EM_spherical_gaussians")

# Unit test for compute_log_probabilities
test_that("compute_probabilities outputs correctly", {
  set.seed(123) # For reproducibility
  n <- 100 # Number of samples
  true_means <- matrix(c(-2, -2, 2, 2), nrow = 2, byrow = TRUE) # Means of the two components
  true_covariances <- list(diag(2), diag(2))  # Covariances (identity matrices)
  true_proportions <- c(0.5, 0.5) # Equal mixture proportions
  data <- generate_mixture_gaussians(n, true_means, true_covariances, true_proportions) # Assume this function works correctly

  k <- 2 # Number of components
  em_results <- EM_spherical_gaussians(data, k, max.iter = 100) # Assume log-space version for stability

  # Test if output is a list containing the correct components
  expect_true(is.list(em_results))
  expect_true(all(c("means", "variances", "proportions", "log_likelihood") %in% names(em_results)))

  # Test if output components have correct dimensions and types
  expect_true(all(dim(em_results$means) == c(k, ncol(data))))
  expect_true(length(em_results$variances) == k)
  expect_true(length(em_results$proportions) == k)

  # Test if variances and proportions are positive and proportions sum to 1
  expect_true(all(em_results$variances > 0))
  expect_true(all(em_results$proportions > 0))
  expect_true(abs(sum(em_results$proportions) - 1) < 1e-6)

  # Test if log likelihood is numeric and not NaN
  expect_true(is.numeric(em_results$log_likelihood))
  expect_false(is.nan(em_results$log_likelihood))
})
