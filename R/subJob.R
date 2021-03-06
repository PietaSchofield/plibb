#' Submit a job to the cluster
#'
#' This functions submits a job in the form of a scriptfile to the cluster via ssh
#'
#' @param batchFile a string representing the name of the script file to be submitted
#' @param user a string with the user name of the person making the ssh connection
#' @param host a string with the name of the login host for the cluster
#' @param qsubstring the submission string for the torque system
#' @param args any arguments to add to the job submission string
#' @param noSub unless set to false will merely display the command rather than submit it.
#' @param scpIt copy to remote using scp before submit when not using FUSE
#'
#' @export
subJob <- function(scriptfile,locRoot=Sys.getenv("HOME"),remRoot="~", 
                   qsubString="qsub",args=NULL, pname=NULL,host="feenix"){
  if(host=="camp"){
    remRoot <- "/home/camp/schofip/Projects"
    qsubString <- "sub"
    remScript <- file.path(remRoot,pname,"Scripts",basename(scriptfile))
  }else{
    remScript <- gsub(locRoot,remRoot,scriptfile)
  }
  paste0(qsubString," ",remScript, " ",args," ")
}
