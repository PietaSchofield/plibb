% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/survClust.R
\name{survClust}
\alias{survClust}
\title{survAnal: runs cox proportional hazard models against patients with top and bottom n percent expression values}
\usage{
survClust(survData = NULL, exprData = NULL, geneData = NULL,
  survTime = "time", cox = F, plotIt = F, survStatus = "status",
  mcores = 4, clustCol = "sampleCl", verbose = FALSE)
}
\arguments{
\item{survData}{survival data must contain a time and status}

\item{exprData}{normalised gene expression data}

\item{geneData}{names of the genes to be tested (must be in the rownames of exprData)}

\item{percExpr}{filter for minimum percentage of samples required to be expression a gene
to select genes for testing}

\item{exprRange}{top and bottom quantiles of expression values to select samples for testing}

\item{sep}{default separator for delimited survival and sample id files supplied}

\item{exprSep}{default separator for expression file supplied}

\item{outputDir}{location to write output files}

\item{analysisName}{stub to add to output file names}

\item{silent}{boolean return the full set of statistics as a data frame}
}
\value{
the function creates several csv output files with the Cox PH results, the Limma DGE results, a combined set
of both results and a set of those genes for which the DGE result is significant at 0.05 FDR
}
\description{
The runCPH function will process three separate file one with sample ids one with survival data and one with
expression values. In test mode if a list of sample ids are supplied but not the other two files it assumes the
ids are from the TCGA SKCM data set and uses a cached version of the normalised expression values from the TCGA
SKCM data set and a currated set of survival data.
}
\details{
It will also perform a limma differential gene expression test for the significance of the fold change between the
top and bottom n percent of expression values
}
\examples{
analysisName="test3"
exprSep=","
res <- runCPH(sampleDataFile=sampleDataFile,expressionDataFile=expressionDataFile,
              survivalDataFile=survivalDataFile,
              analysisName=analysisName,exprSep=exprSep)

}
