% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runCPH.R
\name{runCPH}
\alias{runCPH}
\title{runCPH: runs cox proportional hazard models against patients with top and bottom n percent expression values}
\usage{
runCPH(exprRange = 0.33, percExpr = 0.8, sep = ";", exprSep = sep,
  outputDir = getwd(), silent = F, survData = NULL,
  expressionData = NULL, simple = T, analysisName = paste("run",
  gsub("([ ]|[:])", "_", format(Sys.time()))), scan = T,
  geneList = NULL)
}
\arguments{
\item{exprRange}{top and bottom quantiles of expression values to select samples for testing}

\item{percExpr}{filter for minimum percentage of samples required to be expression a gene
to select genes for testing}

\item{sep}{default separator for delimited survival and sample id files supplied}

\item{exprSep}{default separator for expression file supplied}

\item{outputDir}{location to write output files}

\item{silent}{boolean return the full set of statistics as a data frame}

\item{analysisName}{stub to add to output file names}

\item{sampleDataFile}{name of the a delimited sample data file, first column should contain the
sample id's for samples to match in survival and expression data}

\item{survivalDataFile}{name of the delimited survival data file, first column should contain the
sample ids to match with sample data and expression data. If this file is not specified uses
default data created for TCGA SKCM samples}

\item{expressionDataFile}{name of the delimited expression data file, second row should contain the
sample ids as column headings to match with sample data and expression data. If this file is not specified uses
default data created for TCGA SKCM samples normalised expression values. NB when this file is read in
the first line will be skipped.}
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
