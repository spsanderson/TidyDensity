% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-cumulative-functions.R
\name{csd}
\alias{csd}
\title{Cumulative Standard Deviation}
\usage{
csd(.x)
}
\arguments{
\item{.x}{A numeric vector}
}
\value{
A numeric vector. Note: The first entry will always be
NaN.
}
\description{
A function to return the cumulative standard deviation of a vector.
}
\details{
A function to return the cumulative standard deviation of a vector.
}
\examples{
x <- mtcars$mpg

csd(x)

}
\seealso{
Other Vector Function: 
\code{\link{bootstrap_p_vec}()},
\code{\link{bootstrap_q_vec}()},
\code{\link{cgmean}()},
\code{\link{chmean}()},
\code{\link{ckurtosis}()},
\code{\link{cmean}()},
\code{\link{cmedian}()},
\code{\link{cskewness}()},
\code{\link{cvar}()},
\code{\link{tidy_kurtosis_vec}()},
\code{\link{tidy_scale_zero_one_vec}()},
\code{\link{tidy_skewness_vec}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Vector Function}
