#' Trapezoidal Area Under the Curve
#'
#' Citation: Myerson, J., Green, L., & Warusawitharana, M. (2001). Area under the curve as a measure of discounting. Journal of the experimental analysis of behavior, 76 2, 235-43 .
#'
#' @param df A data frame with one x and one y value on each line.  Optionally,
#' leading x and leading y values can be on each line as well.
#' @param x Column of data frame containing trial index (i.e., successive delays,
#' cognitive effort, probability).  traper function sorts the data by x.  The
#' user should normalize data to obtain canonical auc ranging from
#' 0 to 1.
#' @param y Column of data frame containing subjective values (or scores).  The
#' user should normalize data to obtain canonical auc ranging from
#' 0 to 1.
#' @param x_lead The x_lead column should be the x value from the next row.  If
#' this parameter is not provided, trap_auc will create this column using the traper
#' function.
#' @param y_lead The y_lead column should be the y value from the next row.  If
#' this parameter is not provided, trap_auc will create this column using the traper
#' function.
#'
#' @return A list two items: 1) the total area under the curve (your_list$total)
#' and a data frame (your_list$data) where each row contains the data to compute
#' the area of one trapezoid and the area of one trapezoid.
#' @export
#'
#' @examples
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
#'
#' #Calculate the area under the curve
#' output_test_A <- trap_auc(df_test_2, x = delay, y = value,
#'                           x_lead = delay_lead, y_lead = value_lead)
#' #Get area under the curve
#' output_test_A$total
trap_auc <- function(df, x, y, x_lead, y_lead) {

  # 1. Check if x_lead and y_lead were provided
  # 2. Compute AUC for each row
  if (missing(x_lead) | missing(y_lead)){
    df <- traper(df, {{x}}, {{y}})
    df <- dplyr::mutate(df, auc = (x_lead - {{x}})*(({{y}} + y_lead)/2))
  } else {
    df <- dplyr::mutate(df, auc = ({{x_lead}} - {{x}})*(({{y}} + {{y_lead}})/2))
  }

  #Get total auc
  auc_total <- sum(df$auc)

  #Gather output in list
  output <- list("total" = auc_total,
                 "data" = df)

  #Return output
  return(output)
}
