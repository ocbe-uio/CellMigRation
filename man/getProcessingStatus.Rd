% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_methods_v3.R
\name{getProcessingStatus}
\alias{getProcessingStatus}
\alias{getProcessingStatus,trackedCells-method}
\title{Method getProcessingStatus}
\usage{
getProcessingStatus(x)

\S4method{getProcessingStatus}{trackedCells}(x)
}
\arguments{
\item{x}{a \code{trackedCells}-class object}
}
\value{
a list including Processing Status
}
\description{
Retrieve Processing Status from a \code{trackedCells} object.
}
\examples{
data("TrackCellsDataset")
getProcessingStatus(TrackCellsDataset)

}
