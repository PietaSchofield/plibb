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
#' @param setWH sets this file as the home file in the work directory
#' @param setPI sets this file as the home file in the work directory
#'
#' @export
rc <- function(fileName=.curFile,projDir=.curProj,dirStatus="Projects",
                 inDir=NULL, outDir=NULL,open="html",godPath="public_html/work/Projects",
                 rootDir=file.path(Sys.getenv("HOME"),dirStatus),
                 codeDir=file.path(Sys.getenv("HOME"),dirStatus),
                 sysId=Sys.info()["sysname"],setGH=F,silent=F,
                 htmlApp="firefox",pdfApp="evince",wordApp="loffice",
                 sourcecopy=F,toPDF=F,toDOCX=F,toHTML=T,upload=T,setWH=F,setPI=F){
  if(silent){
    open <- NULL
  }
  if(sysId=="Darwin"){
    htmlApp="open"
    pdfApp="open"
    wordApp="open"
  }
  if(is.null(outDir) & is.null(inDir)){
    infile <- file.path(codeDir,projDir,"Code",paste0(fileName,".Rmd"))
    outpath <- file.path(rootDir,projDir,"Notes")
  }else if(!is.null(outDir) & !is.null(inDir)){
    infile <- file.path(inDir,paste0(fileName,".Rmd"))
    outpath <- file.path(outDir)
  }else{
    stop("either use default project paths or specify both in and out directories")
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
  if(upload){
    if(setGH){
      gotPath <- "public_html"
    }else{
      godPath <- file.path(godPath,projDir)
    }
    if(setWH){
       system(paste0("scp ",htmlFile,
          " pieta@pieta.me:public_html/work/index.html"))
       htmlFile <- "index.html"
    } else if(setPI){
       system(paste0("scp ",htmlFile,
          " pieta@pieta.me:public_html/work/Projects/index.html"))
       htmlFile <- "index.html"
    } else {
      system(paste0("scp ",htmlFile," ",paste0("pieta@pieta.me:",godPath),"/",basename(htmlFile)))
    }
  }
  if(!is.null(open)){
    switch(open,
      pdf=if(toPDF){
        system(paste0(pdfApp," ",pdfFile),wait=F)
      },
      docx=if(toDOCX){
        system(paste0(wordApp," ",docxFile),wait=F)
      },
      html=if(upload){
        if(setWH){
          htmlPath <- "work"
        }else if(setPI){
          htmlPath <- "work/Projects"
        }else{
          htmlPath <- gsub("public_html","",godPath)
        }
        system(paste0(htmlApp," ",file.path("http://pieta.me",htmlPath,basename(htmlFile))),
               wait=F)
      }else{
        system(paste0(htmlApp," ",htmlFile),wait=F)
      }
    )
  }
}
