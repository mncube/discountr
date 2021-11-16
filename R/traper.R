#' Traper
#'
#' Convert df with one x and one y value per row into trapezoidal data where x
#' values represent successive indexes (i.e., successive delays, cognitive effort,
#' probability) and y values represent subjective values associated with the delay.
#'
#' Citation: Myerson, J., Green, L., & Warusawitharana, M. (2001). Area under the curve as a measure of discounting. Journal of the experimental analysis of behavior, 76 2, 235-43 .
#'
#' @param df A data frame with one x and one y value on each line
#' @param x Column of data frame containing trial index (i.e., successive delays,
#' cognitive effort, probability).  traper function sorts the data by x.  The
#' user should normalize data to obtain canonical auc ranging from
#' 0 to 1.
#' @param y Column of data frame containing subjective values (or scores).  The
#' user should normalize data to obtain canonical auc ranging from
#' 0 to 1.
#' @param rename Change name of x_lead and y_lead columns to {{x}}_lead and
#' {{y}}_lead
#'
#' @return Data frame where each row contains the data to compute the area of
#' one trapezoid. The *_lead columns are the x and y values from the next row.
#' @export
#'
#' @examples
#'
#' #Create data frame with successive delays and subjective values
#' df_test <- data.frame(delay = sample(1:100, 50, replace = FALSE),
#'                       value = sample(1:100, 50, replace = TRUE))
#'
#' #Normalize data in preparation for auc calculation
#' df_test$delay <- df_test$delay/max(df_test$delay)
#' df_test$value <- df_test$value/max(df_test$value)
#'
#' #Reformat data in preparation to compute the trapezoidal auc
#' df_test_2 <- traper(df_test, x = delay, y = value, rename = TRUE)
traper <- function(df, x, y, rename = FALSE){

  #Arrange df by x
  df <- dplyr::arrange(df, {{x}})

  #Add leads to previous rows
  df <- dplyr::mutate(df, x_lead = dplyr::lead({{x}}),
                      y_lead = dplyr::lead({{y}}))

  if (rename == TRUE){
    #Rename columns
    x <- deparse(substitute(x))
    y <- deparse(substitute(y))
    names(df)[names(df)=="x_lead"] <- paste0(x, "_lead")
    names(df)[names(df)=="y_lead"] <- paste0(y, "_lead")
  }

  #Remove last row from data frame
  df <- utils::head(df,-1)

  return(df)
}
