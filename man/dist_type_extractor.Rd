% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helper-dist-type-extract.R
\name{dist_type_extractor}
\alias{dist_type_extractor}
\title{Extract Distribution Type from Tidy Distribution Object}
\usage{
dist_type_extractor(.x)
}
\arguments{
\item{.x}{The attribute list passed from a \code{tidy_} distribution function.}
}
\value{
A character string
}
\description{
Get the distribution name in title case from the \code{tidy_} distribution
function.
}
\details{
This will extract the distribution type from a \code{tidy_} distribution
function output using the attributes of that object. You must pass the attribute
directly to the function. It is meant really to be used internally.

You should be passing if using manually the \verb{$tibble_type} attribute.
}
\examples{

tn <- tidy_normal()
atb <- attributes(tn)
dist_type_extractor(atb$tibble_type)

}
\author{
Steven P. Sanderson II,
}
\concept{Helper}
