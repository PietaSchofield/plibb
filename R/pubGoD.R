#' render the current document  
#'
#' renders the named document and puts the output html file in the correct location in my filespace
#' This currently assumes that I have mounted my troodon home directory to the local host via sshfs
#' which is available from OSXFUSE. Default paths are configured for my code locations.
#'
#' Been making changes to this to use bookdown document styles 
#'
#' @param projDir project name
#' @param fileName file name
#' @param codeDir code tree path
#' @param rootDir root of output tree
#' @param inDir override codeDir construction with exact path
#' @param outDir copy to specific output subdirectory
#' @param sourceCopy copy source to the output location too
#' @param toData make a copy of the output in another public location
#' @param dataDir secondary location for copy 
#' @param open view the output file
#' @param locOnly write output to local hardrive rather than network share
#'
#' @export
pubGoD <- function(fileName=.curFile,projDir=.curProj,
                   inDir=NULL, outDir=NULL,open="html",
                   rootDir="/Users/pschofield/Projects",
                   codeDir="/Users/pschofield/Code/CRUK",
                   sourcecopy=F,toPDF=F,toDOCX=F,toHTML=T,
                   godRoot="/Volumes/pietame/public_html",toGoD=F){
  if(is.null(outDir)){
    infile <- file.path(codeDir,projDir,paste0(fileName,".Rmd"))
    outpath <- file.path(rootDir,projDir,"Notes")
    godpath <- file.path(godRoot,"public/Projects",projDir,"Notes")
  }else{
    infile <- file.path(codeDir,inDir,paste0(fileName,".Rmd"))
    outpath <- file.path(rootDir,outDir)
    path <- file.path(godRoot,outDir)
  }
  if(toDOCX){
    docxFile <- rmarkdown::render(input=infile,output_dir=outpath,
                               output_format="bookdown::word_document2")
  }
  if(toHTML){
    htmlFile <- rmarkdown::render(input=infile,output_dir=outpath,
                               output_format="bookdown::html_document2")
  }
  if(toPDF){
    pdfFile <- rmarkdown::render(infile,output_dir=outpath,
                                 output_format="bookdown::pdf_document2")
  }
  if(sourcecopy){
    file.copy(infile,outpath,overwrite=T)
  }
  if(toGoD){
    file.copy(htmlFile,godpath,overwrite=T) 
  }
  if(!is.null(open)){
    switch(open,
      pdf=if(toPDF){
        system(paste0("open ",pdfFile))
      },
      docx=if(toDOCX){
        system(paste0("open ",docxFile))
      },
      system(paste0("open ",htmlFile))
    )
  }
}
