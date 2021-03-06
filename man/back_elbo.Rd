% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/backwash.R
\name{back_elbo}
\alias{back_elbo}
\title{The Evidence lower bound.}
\usage{
back_elbo(betahat_ols, S_diag, Amat, tau2_seq, pivec, lambda_seq, mubeta,
  mubeta_matrix, sig2beta_matrix, gamma_mat, muv, Sigma_v, phi, xi,
  var_inflate_pen = 0)
}
\arguments{
\item{betahat_ols}{A vector of numerics. The ordinary least
squares estimates of the regression coefficients.}

\item{S_diag}{A vector of positive numerics. The standard errors of
\code{betahat_ols}.}

\item{Amat}{The A matrix for the variational EM.}

\item{tau2_seq}{The known grid of prior mixing variances.}

\item{pivec}{The current values of the mixing proportions.}

\item{lambda_seq}{A vector of numerics greater than 1. The
penalties on the pi's.}

\item{mubeta}{The current means of the betas}

\item{mubeta_matrix}{The current mixing means of the variational
densities of the betas.}

\item{sig2beta_matrix}{The current mixing variances of the
variational densities of the betas.}

\item{gamma_mat}{The current mixing proportions of the variational
densities of the betas.}

\item{muv}{A matrix of one column of numerics. The current mean of
v.}

\item{Sigma_v}{The current covariance matrix of the latent v.}

\item{phi}{A numeric. The "g" hyperparameter.}

\item{xi}{A positive numeric. The current value of xi.}

\item{var_inflate_pen}{The penalty to apply on the variance inflation parameter.
Defaults to 0, but should be something non-zero when \code{alpha = 1}
and \code{scale_var = TRUE}.}
}
\description{
The Evidence lower bound.
}
\author{
David Gerard
}
