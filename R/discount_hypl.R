#' The Hyperbolic-Like Discounting Model
#'
#' @param A Amount of reward
#' @param b Discounting rate parameter
#' @param X Independent variable (i.e., delay, cognitive effort, probability)
#' @param s Non-linear scaling factor (set s = 1 to run the hyperbolic discounting model)
#'
#' @return Subjective value of the reward of amount A
#' @export
#'
#' @examples
#' A <- 5000
#' b <- 7.760
#' X <- .5
#' s <- 2
#' discount_hypl(A = A, b = b, X = X, s = s)
discount_hypl <- function(A, b, X, s){

  #Compute Y
  Y <- A/(1 +b*X)^s

  #Return Y
  return(Y)
}
