% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/random-tidy-hypergeometric.R
\name{tidy_hypergeometric}
\alias{tidy_hypergeometric}
\title{Tidy Randomly Generated Hypergeometric Distribution Tibble}
\usage{
tidy_hypergeometric(
  .n = 50,
  .m = 0,
  .nn = 0,
  .k = 0,
  .num_sims = 1,
  .return_tibble = TRUE
)
}
\arguments{
\item{.n}{The number of randomly generated points you want.}

\item{.m}{The number of white balls in the urn}

\item{.nn}{The number of black balls in the urn}

\item{.k}{The number of balls drawn fro the urn.}

\item{.num_sims}{The number of randomly generated simulations you want.}

\item{.return_tibble}{A logical value indicating whether to return the result
as a tibble. Default is TRUE.}
}
\value{
A tibble of randomly generated data.
}
\description{
This function will generate \code{n} random points from a hypergeometric
distribution with a user provided, \code{m},\code{nn}, and \code{k}, and number of random
simulations to be produced. The function returns a tibble with the
simulation number column the x column which corresponds to the n randomly
generated points, the \code{d_}, \code{p_} and \code{q_} data points as well.

The data is returned un-grouped.

The columns that are output are:
\itemize{
\item \code{sim_number} The current simulation number.
\item \code{x} The current value of \code{n} for the current simulation.
\item \code{y} The randomly generated data point.
\item \code{dx} The \code{x} value from the \code{\link[stats:density]{stats::density()}} function.
\item \code{dy} The \code{y} value from the \code{\link[stats:density]{stats::density()}} function.
\item \code{p} The values from the resulting p_ function of the distribution family.
\item \code{q} The values from the resulting q_ function of the distribution family.
}
}
\details{
This function uses the underlying \code{stats::rhyper()}, and its underlying
\code{p}, \code{d}, and \code{q} functions. For more information please see \code{\link[stats:Hypergeometric]{stats::rhyper()}}
}
\examples{
tidy_hypergeometric()

}
\seealso{
\url{https://en.wikipedia.org/wiki/Hypergeometric_distribution}

Other Discrete Distribution: 
\code{\link{tidy_bernoulli}()},
\code{\link{tidy_binomial}()},
\code{\link{tidy_geometric}()},
\code{\link{tidy_negative_binomial}()},
\code{\link{tidy_poisson}()},
\code{\link{tidy_zero_truncated_binomial}()},
\code{\link{tidy_zero_truncated_negative_binomial}()},
\code{\link{tidy_zero_truncated_poisson}()}

Other Hypergeometric: 
\code{\link{util_hypergeometric_param_estimate}()},
\code{\link{util_hypergeometric_stats_tbl}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Discrete Distribution}
\concept{Hypergeometric}
