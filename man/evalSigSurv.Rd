% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evalCluster.R
\name{evalSigSurv}
\alias{evalSigSurv}
\title{evalCluster}
\usage{
evalSigSurv(expData, survData, hm = F, gcl = F, gcts = 10,
  cmeth = "ward.D2", titletxt = "")
}
\arguments{
\item{expData}{is an expression matrix rows=genes cols=samples}

\item{survData}{is a survival data frame with columns time and status}

\item{hm}{generate heatmap boolean}

\item{gcl}{if generating heatmap do or don't cluster the genes as well as the samples}

\item{gcts}{the number of cuts to attempt of the cluster}

\item{cmeth}{hierarchical clustering method (distance is correlation)}
}
\description{
function from etv1 projects not totally sure when I wrote this I have no memory of it
It seems to take the results from the glmnet modelling to perform a KM survival analysis on a
set of expression values split by cluster don't really know what the gcl parameter is all abou
yet
}
