% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_functions_v8.R
\name{getAvailableAggrMetrics}
\alias{getAvailableAggrMetrics}
\title{Get Available Aggregate Cell Metrics}
\usage{
getAvailableAggrMetrics(object)
}
\arguments{
\item{object}{list of length 2, returned by the aggregateFR()
function}
}
\value{
character vector listing all available metrics
}
\description{
Retrieve a list of metrics computed for an aggregated
result object.
This getter function takes the output of aggregateFR() as input.
}
\examples{
data(WSADataset)
wasDF1 <- WSADataset[seq(1,300,by=1), ]
wsaTD1 <- CellMig(wasDF1)
wsaTD1 <- wsaPreProcessing(wsaTD1,FrameN=65)
wsaTD1 <- FMI(wsaTD1,TimeInterval=10)
wsaTD1 <- FinRes(wsaTD1,ParCor=FALSE, export=FALSE)
wasDF2 <- WSADataset[seq(1001,1300,by=1), ]
wsaTD2 <- CellMig(wasDF2)
wsaTD2 <- wsaPreProcessing(wsaTD2,FrameN=65)
wsaTD2 <-FMI(wsaTD2,TimeInterval=10)
wsaTD2 <-FinRes(wsaTD2,ParCor=FALSE, export=FALSE)
AGG <- aggregateFR(wsaTD1 ,wsaTD2 ,export=FALSE)
getAvailableAggrMetrics(AGG)

}
\references{
\url{https://www.data-pulse.com/dev_site/cellmigration/}
}
\author{
Damiano Fantini and
Salim Ghannoum \email{salim.ghannoum@medisin.uio.no}
}
