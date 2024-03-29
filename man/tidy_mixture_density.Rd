% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/random-tidy-mixture.R
\name{tidy_mixture_density}
\alias{tidy_mixture_density}
\title{Tidy Mixture Data}
\usage{
tidy_mixture_density(...)
}
\arguments{
\item{...}{The random data you want to pass. Example rnorm(50,0,1) or something
like tidy_normal(.mean = 5, .sd = 1)}
}
\value{
A list object
}
\description{
Create mixture model data and resulting density and line plots.
}
\details{
This function allows you to make mixture model data. It allows you
to produce density data and plots for data that is not strictly of one family
or of one single type of distribution with a given set of parameters.

For example this function will allow you to mix say tidy_normal(.mean = 0, .sd = 1)
and tidy_normal(.mean = 5, .sd = 1) or you can mix and match distributions.

The output is a list object with three components.
\enumerate{
\item Data
}
\itemize{
\item input_data (The random data passed)
\item dist_tbl (A tibble of the passed random data)
\item density_tbl (A tibble of the x and y data from \code{stats::density()})
}
\enumerate{
\item Plots
}
\itemize{
\item line_plot - Plots the dist_tbl
\item dens_plot - Plots the density_tbl
}
\enumerate{
\item Input Functions
}
\itemize{
\item input_fns - A list of the functions and their parameters passed to the function
itself
}
}
\examples{
output <- tidy_mixture_density(rnorm(100, 0, 1), tidy_normal(.mean = 5, .sd = 1))

output$data

output$plots

output$input_fns

}
\author{
Steven P. Sanderson II, MPH
}
\concept{Mixture Data}
