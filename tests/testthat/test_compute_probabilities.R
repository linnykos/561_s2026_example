context("Testing compute_probabilities")

# Unit test for compute_log_probabilities
test_that("compute_probabilities outputs correctly", {
  set.seed(10)
  # Mock data and parameters for testing
  data <- matrix(rnorm(20), nrow = 10, ncol = 2) # 10 samples, 2-dimensional
  means <- matrix(c(0, 0, 5, 5), nrow = 2, byrow = TRUE) # 2 components
  variances <- c(1, 2)
  proportions <- c(0.5, 0.5)

  probabilities <- compute_probabilities(data, means, variances, proportions)

  # Test if probabilities sum to 1 for each sample
  expect_true(all(abs(rowSums(probabilities) - 1) < 1e-6))

  # Test if probabilities are within the valid range [0,1]
  expect_true(all(probabilities >= 0 & probabilities <= 1))

  # Test for handling of a single sample (edge case)
  single_sample <- data[1, , drop = FALSE] # Prevent dropping to lower dimension
  probabilities_single <- compute_probabilities(single_sample, means, variances, proportions)
  expect_true(dim(probabilities_single)[1] == 1)
  expect_true(all(abs(rowSums(probabilities_single) - 1) < 1e-6))
})
