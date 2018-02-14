#' Dataset Cleansing
#'
#' A function for scrubbing a dataset for usage with most standard algorithms. This involves one-hot-encoding columns that are probably categorical.
#' @param X \code{[n, d]} array with the \code{n} samples in \code{d} dimensions.
#' @param Y \code{[n]} vector with the \code{n} labels for each of the \code{n} samples.
#' @param Kmax the maximum number of classes to consider for encoding variables.
#' @return A list containing the following:
#' \itemize{
#' \item{Xc}{\code{[m, d+r]} the array with \code{m} samples in \code{d+r} dimensions, where \code{r} is the number of additional columns appended for encodings. \code{m < n} when  there are non-finite entries.}
#' \item{Y}{\code{[m] a vector giving the classification labels.}}
#' \item{enc}{An array with code{d+r} elements, with keys for the columns indices of \code{Xc} and elements indicating the name of the feature present at the given index.}
#' \item{samp}{\code{m} the sample ids that are included in the final array, where \code{samp[i]} is the original row id corresponding to \code{Xc[i,]}. If \code{m < n}, there were non-finite entries that were purged.}
#' }
#' @author Eric Bridgeford
clean.dataset <- function(X, Y, Kmax=10) {
  sumX <- apply(X, c(1), sum)
  samp <- which(!is.nan(sumX) & is.finite(sumX))
  X <- X[samp,]; Y <- Y[samp]
  dimx <- dim(X)
  n <- dimx[1]; d <- dimx[2]
  Xce <- lapply(1:d, function(i) {
    unx <- unique(X[,i])
    cname <- colnames(X)[i]
    K <- length(unx)
    if (K > Kmax) {
      # if most of the elements are unique, return the original column
      x <- X[, i]
    } else {
      # one-hot-encode
      x <- array(0, dim=c(n, K))
      for (j in 1:length(unx)) {
        x[which(X[,i] == unx[j]), j] <- 1
      }
    }
    enc <- array(cname, dim=c(ifelse(K > Kmax, 1, K)))
    return(list(enc=enc, x=x))
  })
  enc <- do.call(c, lapply(Xce, function(x) x$enc))
  Xc <- do.call(cbind, lapply(Xce, function(x) x$x))

  return(list(X=Xc, Y=Y, enc=enc, samp=samp))
}
