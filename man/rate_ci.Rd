% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rate_ci.R
\name{rate_ci}
\alias{rate_ci}
\title{Quick rates and confidence intervals}
\usage{
rate_ci(numerator, denominator, alpha, multiplier = 1e+05)
}
\arguments{
\item{numerator}{The numerator of the rate.}

\item{denominator}{The denominator of the rate.}

\item{alpha}{The significance level for the confidence interval}

\item{multiplier}{The multiplier for the rate. Defaults to 100,000.}
}
\description{
This function creates rates and 1-alpha confidence intervals using the Rothman/Greenland method.
}
\examples{
rate_ci()
}
\keyword{Rates}
