#' The Exponential Discounting Model
#'
#' The model was obtained from the conference presentation:
#' Leonard Green, "The Discounting Function" SQAB
#' The presentation can be viewed on Youtube:
#' https://www.youtube.com/watch?v=CDto8pAyG5M
#'
#' The notation was obtained from:
#' Myerson, J., Green, L., & Warusawitharana, M. (2001). Area under the curve as a measure of discounting. Journal of the experimental analysis of behavior, 76 2, 235-43 .
#'
#' @param A Amount of reward
#' @param b Discounting rate parameter
#' @param X Independent variable (i.e., delay, cognitive effort, probability)
#'
#' @return Subjective value of the reward of amount A
#' @export
#'
#' @examples
#' A <- 5000
#' b <- 7.760
#' X <- .5
#' discount_exp(A = A, b = b, X = X)
discount_exp <- function(A, b, X) {

  #Compute Y
  Y <- A*exp(-1*b*X)

  #Return Y
  return(Y)
}
