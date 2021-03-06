% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_functions_v8.R
\name{plotSampleTracks}
\alias{plotSampleTracks}
\title{A 2D rose-plot of sample cells}
\usage{
plotSampleTracks(
  object,
  Type = "l",
  celNum = 35,
  FixedField = TRUE,
  export = FALSE,
  ExpName = NULL
)
}
\arguments{
\item{object}{\code{CellMig} class object, which is a list of
data frames resulted from the PreProcessing.}

\item{Type}{has to be one of the following: c("p", "l", "b", "o")}

\item{celNum}{A numeric value showing the desired number of cells
to be plotted.}

\item{FixedField}{logical(1) Allows generating a plot with
fixed field 800um x 800um. Default is TRUE.}

\item{export}{if `TRUE` (default), exports plot to JPG file
"p": Points;
"l": Lines;
"b": Both;
"o": Both "overplotted".}

\item{ExpName}{string, name of the experiment. Can be NULL}
}
\value{
A 2D rose-plot showing the tracks of sample cells
selected randomly based on the desired number of cells selected
by the user.
}
\description{
Plotting the trajectory data of some cells.
}
\details{
The visualization shows centered trajectories where
the starting point of each track is located at the
origin of the coordinate system (X=0,Y=0).
}
\examples{
preProcCellMig <- cellmigRation::preProcCellMig
plotSampleTracks(preProcCellMig, Type="l", FixedField=TRUE,
                 celNum=5, export=FALSE, ExpName = NULL)

}
\references{
\url{https://www.data-pulse.com/dev_site/cellmigration/}
}
\author{
Salim Ghannoum \email{salim.ghannoum@medisin.uio.no}
}
