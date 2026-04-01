#' Simulate a mixture of Spherical Gaussians
#'
#' @param n number of samples
#' @param means a matrix with \code{p} columns and \code{k} rows (for the
#' number of clusters), where each row represents the mean of a Spherical
#' Gaussian
#' @param covariances a list of \code{k} \code{p} positive definite matrices
#' @param proportions a non-negative vector of length \code{k} that sums to 1,
#' where each value denotes the relative proportion of each cluster
#'
#' @return a \code{n} by \code{p} matrix, where \code{n} is the number of
#' samples and \code{p} is the number of features
#' @export
#'
#' @examples
#' n <- 500
#' means <- matrix(c(0, 0, 5, 5), ncol = 2, byrow = TRUE)
#' covariances <- list(diag(2),
#'                     diag(2))
#' proportions <- c(0.5, 0.5)
#' data <- generate_mixture_gaussians(n, means, covariances, proportions)
#' head(data)
generate_mixture_gaussians <- function(n,
                                       means,
                                       covariances,
                                       proportions) {
  k <- nrow(means) # Number of components
  data <- matrix(nrow = n, ncol = 2)
  component <- sample(1:k, n, replace = TRUE, prob = proportions)

  for (i in 1:k) {
    indices <- which(component == i)
    data[indices,] <- MASS::mvrnorm(n = length(indices),
                                    mu = means[i,],
                                    Sigma = covariances[[i]])
  }

  return(data)
}
