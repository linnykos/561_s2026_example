#' EM algorithm for Spherical Gaussians
#'
#' @param data \code{n} by \code{p} matrix, where \code{n} is the number of
#' samples and \code{p} is the number of features
#' @param k number of clusters
#' @param max.iter maximum iteration of EM
#' @param tol relative change in log-likelihood. If the change is less than
#' \code{tol}, then the method terminates early.
#'
#' @return a list with elements \code{means}, \code{variances},
#' \code{proportions}, and \code{log_likelihood} for all the respective
#' estimated components of the mixture of Spherical Gaussians
#' @export
#'
#' @examples
#' n <- 500
#' means <- matrix(c(0, 0, 5, 5), ncol = 2, byrow = TRUE)
#' covariances <- list(diag(2),
#'                     diag(2))
#' proportions <- c(0.5, 0.5)
#' data <- generate_mixture_gaussians(n, means, covariances, proportions)
#'
#' # Fit EM algorithm to the generated data
#' k <- 2 # Number of Gaussian components
#' em_results <- EM_spherical_gaussians(data, k)
#' em_results
EM_spherical_gaussians <- function(data,
                                   k,
                                   max.iter = 100,
                                   tol = 1e-6) {
  n <- nrow(data)
  d <- ncol(data)

  # Initializations
  means <- data[sample(1:n, k),,drop = F]
  variances <- rep(1, k)
  proportions <- rep(1/k, k)
  log_likelihood_old <- -Inf

  for (iter in 1:max.iter) {
    # E-step: Compute log responsibilities using the log-sum-exp trick
    log_responsibilities <- matrix(nrow = n, ncol = k)
    for (i in 1:k) {
      sigma_i <- diag(variances[i], d, d) # Spherical covariance matrix
      log_responsibilities[,i] <- log(proportions[i]) + mvtnorm::dmvnorm(data, mean = means[i,], sigma = sigma_i, log = TRUE)
    }

    # Log-sum-exp trick for normalization
    max_log <- apply(log_responsibilities, 1, max)
    log_sum_exp <- max_log + log(rowSums(exp(log_responsibilities - max_log)))
    log_responsibilities_normalized <- log_responsibilities - log_sum_exp

    responsibilities <- exp(log_responsibilities_normalized)

    # M-step: Update parameters
    for (i in 1:k) {
      Nk <- sum(responsibilities[,i])
      means[i,] <- colSums(data * responsibilities[,i]) / Nk
      variances[i] <- sum(sapply(1:n, function(j) sum((data[j,]-means[i,])^2)) * responsibilities[,i]) / (Nk * d)
      proportions[i] <- Nk / n
    }

    # Check for convergence
    log_likelihood_new <- sum(log(rowSums(responsibilities)))
    if (iter > 1 && abs(log_likelihood_new - log_likelihood_old)/log_likelihood_old < tol) break
    log_likelihood_old <- log_likelihood_new
  }

  return(list(means = means,
              variances = variances,
              proportions = proportions,
              log_likelihood = log_likelihood_old))
}

#' Compute the probabilites after EM
#'
#' Specifically, compute the probabilities of each sample originating from the
#' Spherical Gaussian (after running \code{EM_spherical_gaussians})
#'
#' @param data \code{n} by \code{p} matrix, where \code{n} is the number of
#' samples and \code{p} is the number of features
#' @param means a matrix with \code{p} columns and \code{k} rows (for the
#' number of clusters), where each row represents the mean of a Spherical
#' Gaussian
#' @param variances a non-negative vector of length \code{k}, where each value
#' denotes the variance of the Spherical Gaussian
#' @param proportions a non-negative vector of length \code{k} that sums to 1,
#' where each value denotes the relative proportion of each cluster
#'
#' @return a matrix of \code{n} by \code{k}, where each row denotes the
#' probability that each sample was drawn from that cluster. Each row sums to 1
#' and is non-negative
#' @export
#'
#' @examples
#' n <- 500
#' means <- matrix(c(0, 0, 5, 5), ncol = 2, byrow = TRUE)
#' covariances <- list(diag(2),
#'                     diag(2))
#' proportions <- c(0.5, 0.5)
#' data <- generate_mixture_gaussians(n, means, covariances, proportions)
#'
#' # Fit EM algorithm to the generated data
#' k <- 2 # Number of Gaussian components
#' em_results <- EM_spherical_gaussians(data, k)
#' means_estimated <- em_results$means
#' variances_estimated <- em_results$variances
#' proportions_estimated <- em_results$proportions
#'
#' # Compute the probabilities for each sample
#' probabilities <- compute_probabilities(data = data,
#'                                        means = means_estimated,
#'                                        variances = variances_estimated,
#'                                        proportions = proportions_estimated)
#' head(probabilities)
compute_probabilities <- function(data,
                                  means,
                                  variances,
                                  proportions) {
  n <- nrow(data)
  k <- nrow(means)
  d <- ncol(data)

  log_probabilities <- matrix(nrow = n, ncol = k)

  for (i in 1:k) {
    sigma_i <- diag(variances[i], d, d) # Spherical covariance matrix for component i
    # Compute log probabilities directly
    log_probabilities[,i] <- -log(proportions[i]) + mvtnorm::dmvnorm(data, mean = means[i,], sigma = sigma_i, log = TRUE)
  }

  # Use log-sum-exp trick to normalize log probabilities
  max_log_probabilities <- apply(log_probabilities, 1, max)
  log_sum_exp <- max_log_probabilities + log(rowSums(exp(log_probabilities - max_log_probabilities)))
  log_probabilities_normalized <- log_probabilities - log_sum_exp

  return(exp(log_probabilities_normalized)) # Return to the original domain
}


