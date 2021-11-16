
<!-- README.md is generated from README.Rmd. Please edit that file -->

# discountr

<!-- badges: start -->
<!-- badges: end -->

The goal of discountr is to provide data analysis tools for discounting
studies.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mncube/discountr")
```

## Example

This is a basic example which shows you how to compute the area under
the empirical discounting function using the trapezoid approximation as
described in:

Myerson, J., Green, L., & Warusawitharana, M. (2001). Area under the
curve as a measure of discounting. Journal of the experimental analysis
of behavior, 76 2, 235-43 .

``` r
library(discountr)

#Create data frame with successive delays and subjective values
df_disc <- data.frame(delay = sample(1:100, 50, replace = FALSE),
                      value = sample(1:100, 50, replace = TRUE))

#Normalize data in preparation for the auc calculation
#This will ensure that the auc is between 0 and 1
df_disc$delay <- df_disc$delay/max(df_disc$delay)
df_disc$value <- df_disc$value/max(df_disc$value)

#Calculate the area under the curve
output_disc <- trap_auc(df_disc, x = delay, y = value)

#Get the total area under the curve (i.e., sum over trapezoids)
output_disc$total
#> [1] 0.4738

#Get the data frame containing the area under the curve for each trapezoid
head(output_disc$data)
#>   delay value x_lead y_lead     auc
#> 1  0.02  0.40   0.03   0.28 0.00340
#> 2  0.03  0.28   0.06   0.44 0.01080
#> 3  0.06  0.44   0.07   0.73 0.00585
#> 4  0.07  0.73   0.08   0.77 0.00750
#> 5  0.08  0.77   0.09   0.64 0.00705
#> 6  0.09  0.64   0.10   0.47 0.00555
```

You can also convert the data frame to trapazoidal form and then
explicitly provide the x\_lead and y\_lead values when computing the
area under the empirical discounting function:

``` r
#Create data frame with successive delays and subjective values
df_disc_2 <- data.frame(delay = sample(1:100, 50, replace = FALSE),
                      value = sample(1:100, 50, replace = TRUE))

#Normalize data in preparation for auc calculation
df_disc_2$delay <- df_disc_2$delay/max(df_disc_2$delay)
df_disc_2$value <- df_disc_2$value/max(df_disc_2$value)

#Reformat data in preparation to compute the trapezoidal auc
#The resulting data frame will have two new columns:
#delay_lead and value_lead
df_disc_2 <- traper(df_disc_2, x = delay, y = value, rename = TRUE)

#Calculate the area under the curve explicitly defining x_lead and y_lead
output_disc_2<- trap_auc(df_disc_2, x = delay, y = value,
                          x_lead = delay_lead, y_lead = value_lead)

#Get the total area under the curve (i.e., sum over trapezoids)
output_disc_2$total
#> [1] 0.5416667

#Get the data frame containing the area under the curve for each trapezoid
head(output_disc_2$data)
#>        delay value delay_lead value_lead         auc
#> 1 0.01010101  0.58 0.02020202       0.95 0.007727273
#> 2 0.02020202  0.95 0.03030303       0.78 0.008737374
#> 3 0.03030303  0.78 0.07070707       0.53 0.026464646
#> 4 0.07070707  0.53 0.08080808       0.29 0.004141414
#> 5 0.08080808  0.29 0.16161616       0.71 0.040404040
#> 6 0.16161616  0.71 0.17171717       0.95 0.008383838
```
