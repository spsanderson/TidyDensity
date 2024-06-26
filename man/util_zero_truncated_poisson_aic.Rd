% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-aic-ztpoisson.R
\name{util_zero_truncated_poisson_aic}
\alias{util_zero_truncated_poisson_aic}
\title{Calculate Akaike Information Criterion (AIC) for zero-truncated poisson Distribution}
\usage{
util_zero_truncated_poisson_aic(.x)
}
\arguments{
\item{.x}{A numeric vector containing the data to be fitted to a zero-truncated poisson distribution.}
}
\value{
The AIC value calculated based on the fitted zero-truncated poisson distribution to the provided data.
}
\description{
This function estimates the parameters of a zero-truncated poisson distribution from the provided data using maximum likelihood estimation,
and then calculates the AIC value based on the fitted distribution.
}
\details{
This function calculates the Akaike Information Criterion (AIC) for a zero-truncated poisson distribution fitted to the provided data.
}
\examples{
library(actuar)

# Example 1: Calculate AIC for a sample dataset
set.seed(123)
x <- rztpois(30, lambda = 3)
util_zero_truncated_poisson_aic(x)

}
\seealso{
Other Utility: 
\code{\link{check_duplicate_rows}()},
\code{\link{convert_to_ts}()},
\code{\link{quantile_normalize}()},
\code{\link{tidy_mcmc_sampling}()},
\code{\link{util_beta_aic}()},
\code{\link{util_binomial_aic}()},
\code{\link{util_cauchy_aic}()},
\code{\link{util_chisq_aic}()},
\code{\link{util_exponential_aic}()},
\code{\link{util_f_aic}()},
\code{\link{util_gamma_aic}()},
\code{\link{util_generalized_beta_aic}()},
\code{\link{util_generalized_pareto_aic}()},
\code{\link{util_geometric_aic}()},
\code{\link{util_hypergeometric_aic}()},
\code{\link{util_inverse_burr_aic}()},
\code{\link{util_inverse_pareto_aic}()},
\code{\link{util_inverse_weibull_aic}()},
\code{\link{util_logistic_aic}()},
\code{\link{util_lognormal_aic}()},
\code{\link{util_negative_binomial_aic}()},
\code{\link{util_normal_aic}()},
\code{\link{util_paralogistic_aic}()},
\code{\link{util_pareto1_aic}()},
\code{\link{util_pareto_aic}()},
\code{\link{util_poisson_aic}()},
\code{\link{util_t_aic}()},
\code{\link{util_triangular_aic}()},
\code{\link{util_uniform_aic}()},
\code{\link{util_weibull_aic}()},
\code{\link{util_zero_truncated_binomial_aic}()},
\code{\link{util_zero_truncated_geometric_aic}()},
\code{\link{util_zero_truncated_negative_binomial_aic}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Utility}
