% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/est-param-negative-binomial.R
\name{util_negative_binomial_param_estimate}
\alias{util_negative_binomial_param_estimate}
\title{Estimate Negative Binomial Parameters}
\usage{
util_negative_binomial_param_estimate(
  .x,
  .size = 1,
  .auto_gen_empirical = TRUE
)
}
\arguments{
\item{.x}{The vector of data to be passed to the function.}

\item{.size}{The size parameter, the default is 1.}

\item{.auto_gen_empirical}{This is a boolean value of TRUE/FALSE with default
set to TRUE. This will automatically create the \code{tidy_empirical()} output
for the \code{.x} parameter and use the \code{tidy_combine_distributions()}. The user
can then plot out the data using \verb{$combined_data_tbl} from the function output.}
}
\value{
A tibble/list
}
\description{
The function will return a list output by default, and  if the parameter
\code{.auto_gen_empirical} is set to \code{TRUE} then the empirical data given to the
parameter \code{.x} will be run through the \code{tidy_empirical()} function and combined
with the estimated negative binomial data.

Three different methods of shape parameters are supplied:
\itemize{
\item MLE/MME
\item MMUE
\item MLE via \code{\link[stats]{optim}} function.
}
}
\details{
This function will attempt to estimate the negative binomial size and prob
parameters given some vector of values.
}
\examples{
library(dplyr)
library(ggplot2)

x <- as.integer(mtcars$mpg)
output <- util_negative_binomial_param_estimate(x, .size = 1)

output$parameter_tbl

output$combined_data_tbl |>
  tidy_combined_autoplot()

t <- rnbinom(50, 1, .1)
util_negative_binomial_param_estimate(t, .size = 1)$parameter_tbl

}
\seealso{
Other Parameter Estimation: 
\code{\link{util_bernoulli_param_estimate}()},
\code{\link{util_beta_param_estimate}()},
\code{\link{util_binomial_param_estimate}()},
\code{\link{util_burr_param_estimate}()},
\code{\link{util_cauchy_param_estimate}()},
\code{\link{util_chisquare_param_estimate}()},
\code{\link{util_exponential_param_estimate}()},
\code{\link{util_f_param_estimate}()},
\code{\link{util_gamma_param_estimate}()},
\code{\link{util_generalized_beta_param_estimate}()},
\code{\link{util_generalized_pareto_param_estimate}()},
\code{\link{util_geometric_param_estimate}()},
\code{\link{util_hypergeometric_param_estimate}()},
\code{\link{util_inverse_burr_param_estimate}()},
\code{\link{util_inverse_pareto_param_estimate}()},
\code{\link{util_inverse_weibull_param_estimate}()},
\code{\link{util_logistic_param_estimate}()},
\code{\link{util_lognormal_param_estimate}()},
\code{\link{util_normal_param_estimate}()},
\code{\link{util_paralogistic_param_estimate}()},
\code{\link{util_pareto1_param_estimate}()},
\code{\link{util_pareto_param_estimate}()},
\code{\link{util_poisson_param_estimate}()},
\code{\link{util_t_param_estimate}()},
\code{\link{util_triangular_param_estimate}()},
\code{\link{util_uniform_param_estimate}()},
\code{\link{util_weibull_param_estimate}()},
\code{\link{util_zero_truncated_binomial_param_estimate}()},
\code{\link{util_zero_truncated_geometric_param_estimate}()},
\code{\link{util_zero_truncated_negative_binomial_param_estimate}()},
\code{\link{util_zero_truncated_poisson_param_estimate}()}

Other Binomial: 
\code{\link{tidy_binomial}()},
\code{\link{tidy_negative_binomial}()},
\code{\link{tidy_zero_truncated_binomial}()},
\code{\link{tidy_zero_truncated_negative_binomial}()},
\code{\link{util_binomial_param_estimate}()},
\code{\link{util_binomial_stats_tbl}()},
\code{\link{util_zero_truncated_binomial_param_estimate}()},
\code{\link{util_zero_truncated_binomial_stats_tbl}()},
\code{\link{util_zero_truncated_negative_binomial_param_estimate}()},
\code{\link{util_zero_truncated_negative_binomial_stats_tbl}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Binomial}
\concept{Parameter Estimation}
