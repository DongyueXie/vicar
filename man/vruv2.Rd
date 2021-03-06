% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ruv2.R
\name{vruv2}
\alias{vruv2}
\title{Calibrated RUV2.}
\usage{
vruv2(Y, X, ctl, k = NULL, cov_of_interest = ncol(X),
  likelihood = c("t", "normal"), limmashrink = TRUE,
  degrees_freedom = NULL, include_intercept = TRUE, gls = TRUE,
  fa_func = pca_2step, fa_args = list(), use_factor = FALSE,
  force_check = TRUE, fa_limmashrink = TRUE)
}
\arguments{
\item{Y}{A matrix of numerics. These are the response variables
where each column has its own variance. In a gene expression
study, the rows are the individuals and the columns are the
genes.}

\item{X}{A matrix of numerics. The covariates of interest.}

\item{ctl}{A vector of logicals of length \code{ncol(Y)}. If
position i is \code{TRUE} then position i is considered a
negative control.}

\item{k}{A non-negative integer.The number of unobserved
confounders. If not specified and the R package sva is
installed, then this function will estimate the number of
hidden confounders using the methods of Buja and Eyuboglu
(1992).}

\item{cov_of_interest}{A vector of positive integers. The column
numbers of the covariates in X whose coefficients you are
interested in. The rest are considered nuisance parameters and
are regressed out by OLS.}

\item{likelihood}{Either \code{"normal"} or \code{"t"}. If
\code{likelihood = "t"}, then the user may provide the degrees
of freedom via \code{degrees_freedom}.}

\item{limmashrink}{A logical. Should we apply hierarchical
shrinkage to the variances (\code{TRUE}) or not (\code{FALSE})?
If \code{degrees_freedom = NULL} and \code{limmashrink = TRUE}
and \code{likelihood = "t"}, then we'll also use the limma
returned degrees of freedom.}

\item{degrees_freedom}{if \code{likelihood = "t"}, then this is the
user-defined degrees of freedom for that distribution. If
\code{degrees_freedom} is \code{NULL} then the degrees of
freedom will be the sample size minus the number of covariates
minus \code{k}.}

\item{include_intercept}{A logical. If \code{TRUE}, then it will
check \code{X} to see if it has an intercept term. If not, then
it will add an intercept term. If \code{FALSE}, then \code{X}
will be unchanged.}

\item{gls}{A logical. Should we estimate the part of the
confounders associated with the nuisance parameters with gls
(\code{TRUE}) or with ols (\code{FALSE}).}

\item{fa_func}{A factor analysis function. It must take parameters:
\code{Y} a data matrix of numerics, \code{r} a positive integer
for the rank, and \code{vr} a positive integer for the number
of the first rows that have a different variance than the last
rows. It must return: \code{alpha} a matrix for the factor
loadings, \code{Z} a matrix for the factors, \code{sig_diag} a
vector of the column-wise variances, and \code{lambda} a
numeric for the variance inflation of the first \code{vr} rows
of \code{Y}. The default function is \code{\link{pca_2step}},
which is the main difference between RUV2 and this version.}

\item{fa_args}{A list. Additional arguments you want to pass to
fa_func.}

\item{use_factor}{A logical. Should we use the estimates of
\code{alpha} and \code{sig_diag} from the factor analysis
(\code{TRUE}), or re-estimate these using OLS as RUV2 does it
(\code{FALSE})? Right now it's probably a bad idea to have the
settings \code{use_factor = TRUE, fa_limmashrink = TRUE,
limmashrink = TRUE} since then the variance estimates of the
control genes are being shrunk twice.}

\item{force_check}{A logical. Are you REALLY sure you want to use
another fa_func (\code{FALSE}) or should I ask you again
(\code{TRUE})?}

\item{fa_limmashrink}{A logical. Should we shrink the variances
during the factor analysis step (\code{TRUE}) or not
(\code{FALSE})?}
}
\value{
A list whose elements are:

    \code{betahat} A matrix of numerics. The ordinary least
    squares estimates of the coefficients of the covariate of
    interest WHEN YOU ALSO INCLUDE THE ESTIMATES OF THE UNOBSERVED
    CONFOUNDERS.

    \code{sebetahat} A matrix of positive numerics. This is the
    post-inflation adjusted standard errors for \code{ruv$betahat}.

    \code{tstats} A vector of numerics. The t-statistics for
    testing against the null hypothesis of the coefficient of the
    covariate of interest being zero. This is after estimating the
    variance inflation parameter.

    \code{pvalues} A vector of numerics. The p-values of said test
    above.

    \code{alphahat} A matrix of numerics. The estimates of the
    coefficients of the hidden confounders. Only identified up to a
    rotation on the rowspace.

    \code{Zhat} A matrix of numerics. The estimates of the
    confounding variables. Only identified up to a rotation on the
    columnspace.

    \code{sigma2} A vector of positive numerics. The estimates of
    the variances PRIOR to inflation.

    \code{sigma2_adjusted} A vector of positive numerics. The
    estimates of the variances AFTER to inflation. This is equal to
    \code{sigma2 * multiplier}.

    \code{multiplier} A numeric. The estimated variance inflation
    parameter.

    \code{mult_matrix} A matrix of numerics. Equal to
    \code{solve(t(cbind(X, Zhat)) \%*\% cbind(X, Zhat))}. One
    multiplies \code{sigma2} or \code{simga2_adjused} by the
    diagonal elements of \code{mult_matrix} to get the standard
    errors of \code{betahat}.

    \code{degrees_freedom} The degrees of freedom of the t-
    statistics.
}
\description{
This function will perform a variant of Removing Unwanted Variation
2-step (RUV2) (Gagnon-Bartsch et al, 2013), where we include a
variance inflation parameter in the factor analysis.
}
\details{
See \code{\link{vruv4}} for a description of the model.

You can provide your own factor analysis, but it must include an
estimate for the variance inflation parameter. This turns out to be
pretty hard. The way I do it now seems to work OK.
}
\references{
\itemize{
\item{Gagnon-Bartsch, J., Laurent Jacob, and Terence
    P. Speed. "Removing unwanted variation from high dimensional
    data with negative controls."
    Berkeley: Department of Statistics. University of California
    (2013).}
\item{Andreas Buja and Nermin
    Eyuboglu. "Remarks on parallel analysis." Multivariate behavior
    research, 27(4):509-540, 1992.}
\item{Gerard, David, and Matthew Stephens. 2019. "Unifying and Generalizing Methods for Removing Unwanted Variation Based on Negative Controls." \emph{Statistica Sinica}, in press. <\href{https://doi.org/10.5705/ss.202018.0345}{doi:10.5705/ss.202018.0345}>.}
}
}
\seealso{
\code{\link{pca_2step}} for the special factor analysis
    that results in variance inflation in RUV2.
}
\author{
David Gerard
}
