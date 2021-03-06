% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_methods_v3.R
\name{getCellTrackStats}
\alias{getCellTrackStats}
\alias{getCellTrackStats,trackedCells-method}
\title{Method getCellTrackStats}
\usage{
getCellTrackStats(x)

\S4method{getCellTrackStats}{trackedCells}(x)
}
\arguments{
\item{x}{a \code{trackedCells}-class object}
}
\value{
a list including Track statistics
}
\description{
Retrieve Stats from a \code{trackedCells} object.
}
\examples{
data("TrackCellsDataset")
getCellTrackStats(TrackCellsDataset)

}
