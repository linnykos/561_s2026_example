context("Testing example")

# Unit test for compute_log_probabilities
test_that("example works", {
  set.seed(10)
  res <- run_example()

  expect_true(is.list(res))
  expect_true(all(sort(names(res)) == sort(c("data", "em_results", "probabilities"))))
})
