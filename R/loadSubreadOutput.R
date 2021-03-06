#'  Load Fcount output from : DEXSeq_after_Fcount.R into DEXSeq
#'  Copyright 2015 Vivek Bhardwaj (bhardwaj@ie-freiburg.mpg.de). Licence: GPLv3.
#'  Read Fcount output and convert to dxd
#' 
#' @export
loadSubreadOutput <- function(countFile, sampleData, 
                     design = ~sample + exon + condition:exon, flattenedfile = NULL) {
  # Take a fcount file and convert it to dcounts for dexseq
  message("Reading and adding Exon IDs for DEXSeq")
  fc <- read.table(countFile,,head=T,skip = 1)
  fc <- dplyr::arrange(fc, Geneid,Chr,Start) 
  dcounts <- dplyr::select(fc,-c(2:6))
  id <- as.character(dcounts[,1])
  n <- id
  split(n,id) <- lapply(split(n ,id), seq_along )
  rownames(dcounts) <- sprintf("%s%s%03.f",id,":E",as.numeric(n))
  dcounts <- dcounts[,2:ncol(dcounts)]
  dcounts <- dcounts[substr(rownames(dcounts), 1, 1) != "_", ] #remove _ from beginnning of gene name 
  ## get genes and exon names out
  splitted <- strsplit(rownames(dcounts), ":")
  exons <- sapply(splitted, "[[", 2)
  genesrle <- sapply(splitted, "[[", 1)
  ## parse the flattened file
  if(!is.null(flattenedfile)) {
    aggregates <- read.delim(flattenedfile, stringsAsFactors = FALSE, 
                             header = FALSE)
    colnames(aggregates) <- c("chr", "source", "class", "start", 
                              "end", "ex", "strand", "ex2", "attr")
    aggregates$strand <- gsub("\\.", "*", aggregates$strand)
    aggregates <- aggregates[which(aggregates$class == "exon"),] # exonic_part 
    aggregates$attr <- gsub("\"|=|;", "", aggregates$attr)
    aggregates$gene_id <- sub(".*gene_id\\s(\\S+).*", "\\1", aggregates$attr)
    transcripts <- gsub(".*transcripts\\s(\\S+).*", "\\1", aggregates$attr)
    transcripts <- strsplit(transcripts, "\\+")
    exonids <- gsub(".*exon_number\\s(\\S+).*", "\\1", aggregates$attr)
    exoninfo <- GRanges(as.character(aggregates$chr), IRanges(start = aggregates$start, 
                                    end = aggregates$end), strand = aggregates$strand)
    names(exoninfo) <- paste(aggregates$gene_id, exonids, sep = ":E")
    names(transcripts) <- names(exoninfo) ## bug in their code. was rownames(exoninfo)
    if(!all(rownames(dcounts) %in% names(exoninfo))) {
      stop("Count files do not correspond to the flattened annotation file")
    }
    matching <- match(rownames(dcounts), names(exoninfo))
    stopifnot(all(names(exoninfo[matching]) == rownames(dcounts)))
    stopifnot(all(names(transcripts[matching]) == rownames(dcounts)))
    dxd <- DEXSeqDataSet(dcounts, sampleData, design, exons, 
                         genesrle, exoninfo[matching], transcripts[matching])
  } else {
    dxd <- DEXSeqDataSet(dcounts, sampleData, design, exons, genesrle)
  }
  return(dxd)
}
