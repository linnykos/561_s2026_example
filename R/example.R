#' Simulate an example
#'
#' @param n number of samples
#'
#' @return a list containing \code{data} (the dataset generated),
#' \code{em_results} (the output of \code{EM_spherical_gaussians}),
#' and \code{probabilities} (the output of \code{compute_probabilities})
#'
#' This program uses the following functions:
#' \code{generate_mixture_gaussians},
#' \code{EM_spherical_gaussians}, and
#' \code{compute_probabilities}.
#'
#' @export
#' @seealso
#' \code{generate_mixture_gaussians()}, \code{EM_spherical_gaussians()},
#' and \code{compute_probabilities()}
#' @examples
#' res <- run_example()
#' res$em_results
run_example <- function(n = 5000){
  means <- matrix(c(0, 0, 5, 5, 2, 2), ncol = 2, byrow = TRUE)
  covariances <- list(diag(2),
                      1.5*diag(2),
                      0.1*diag(2))
  proportions <- c(0.2, 0.4, 0.4)
  data <- generate_mixture_gaussians(n, means, covariances, proportions)

  # Fit EM algorithm to the generated data
  k <- 3 # Number of Gaussian components in this example
  em_results <- EM_spherical_gaussians(data, k)

  # Assuming em_results is the output from EM_spherical_gaussians
  means_estimated <- em_results$means
  variances_estimated <- em_results$variances
  proportions_estimated <- em_results$proportions

  # Compute the probabilities for each sample
  probabilities <- compute_probabilities(data = data,
                                             means = means_estimated,
                                             variances = variances_estimated,
                                             proportions = proportions_estimated)

  list(data = data,
       em_results = em_results,
       probabilities = probabilities)
}
