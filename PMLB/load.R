#' Load from PMLB Dataset
#'
#' A function to load a specified dataset from the PMLB dataset.
#' @param dataset the name of the dataset as it appears in the PMLB repository.
#' @param pmlbpath the path to the PMLB repository locally.
#' @param task the type of the task, either "classification" or "regression". Defaults to "classification".
#' @return A list containing the following:
#' \itemize{
#' \item{X}{\code{[n, d]} array with the \code{n} samples in \code{d} dimensions.}
#' \item{Y}{\code{[n]} vector with labels for each of the \code{n} samples.}
#' }
#' @author Eric Bridgeford
load.pmlb <- function(dataset, pmlbpath, task) {
  if (! task %in% c("classification", "regression")) {
    stop("Please enter a valid task type.")
  }
  dset_path <- file.path(pmlbpath, 'datasets', task, dataset, paste(dataset, '.tsv', sep=""))
  dset_pathgz <- paste(dset_path, '.gz', sep="")
  if (!file.exists(dset_path)) {
    require(R.utils)
    tryCatch(gunzip(dset_pathgz), error=function(e) {
      print(sprintf("We did not find the uncompressed file %s, nor the compressed file %s.", dset_path, dset_pathgz))
      print("Did you enter the dataset, pmlbpath, and task correctly?")
      stop(e)
    })
  }

  result <- read.table(dset_path, header=TRUE, sep="")
  X <- result[, colnames(result) != 'target']; Y <- result[, colnames(result) == 'target']
  return(list(X=X, Y=Y))
}
