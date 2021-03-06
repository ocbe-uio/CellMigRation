% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_functions_v8.R
\name{getPopulationStats}
\alias{getPopulationStats}
\title{Get Cell population stats}
\usage{
getPopulationStats(tc_obj)
}
\arguments{
\item{tc_obj}{a trackedCells object}
}
\value{
data.frame including cell population stats
}
\description{
Extract cell population statistics from a trackedCells object
}
\examples{
x <- cellmigRation::TrackCellsDataset
getPopulationStats(x)


}
\references{
\url{https://www.data-pulse.com/dev_site/cellmigration/}
\url{https://www.mathworks.com/matlabcentral/fileexchange/60349-fasttracks}
}
\author{
Damiano Fantini, \email{damiano.fantini@gmail.com}
}
