% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ssBAMtoBWs.R
\name{ssBAMtoBWs}
\alias{ssBAMtoBWs}
\title{create strand specific bigwigs from a standed bamfile}
\usage{
ssBAMtoBWs(inFile, outDir, projName,
  outRoot = file.path("/scratch/pschofield/Projects", projName),
  ucscMod = "apps/ucscsuite/20150630/linux-x86_64",
  samtoolsMod = "apps/samtools/1.3.1/gcc-4.4.7",
  bedtoolsMod = "apps/bedtools/2.25.0/gcc-4.4.7")
}
\arguments{
\item{inFile}{input bam file}

\item{outDir}{output directory}

\item{projName}{name of the project}
}
\description{
create strand specific bigwigs from a standed bamfile
}
