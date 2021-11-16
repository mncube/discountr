
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
#> [1] 0.4964062

#Get the data frame containing the area under the curve for each trapezoid
head(output_disc$data)
#>   delay     value x_lead    y_lead         auc
#> 1  0.01 0.5312500   0.02 0.7604167 0.006458333
#> 2  0.02 0.7604167   0.03 0.6562500 0.007083333
#> 3  0.03 0.6562500   0.04 0.5208333 0.005885417
#> 4  0.04 0.5208333   0.05 0.6666667 0.005937500
#> 5  0.05 0.6666667   0.08 0.3854167 0.015781250
#> 6  0.08 0.3854167   0.09 0.8750000 0.006302083
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
#> [1] 0.4926

#Get the data frame containing the area under the curve for each trapezoid
head(output_disc_2$data)
#>   delay value delay_lead value_lead     auc
#> 1  0.02  0.87       0.05       0.96 0.02745
#> 2  0.05  0.96       0.06       0.94 0.00950
#> 3  0.06  0.94       0.07       0.21 0.00575
#> 4  0.07  0.21       0.09       0.78 0.00990
#> 5  0.09  0.78       0.10       0.17 0.00475
#> 6  0.10  0.17       0.11       0.02 0.00095
```

The package also contains functions to compute the exponential
discounting model (commonly used in economics) and the hyperbolic-like
discounting model (commonly used in behavioral data analysis)

``` r
#Set up values for models.  In this example assume that rewards are in dollars and delays are in days
A <- 100 #True amount of reward (in dollars for this example)
b <- 1/10 #Discounting rate parameter
X <- 2 #Delay (in days for his example)
s <- 2 #Non-linear scaling factor

#Exponential model (Standard economic account)
discount_exp(A = A, b = b, X = X)
#> [1] 81.87308

#Hyperbolic-like model (Behavioral model)
discount_hypl(A = A, b = b, X = X, s = s)
#> [1] 69.44444

#Hyperbolic model (Behavioral model, must use s = 1)
discount_hypl(A = A, b = b, X = X, s = 1)
#> [1] 83.33333
```
