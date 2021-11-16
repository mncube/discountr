
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
#> [1] 0.5842929

#Get the data frame containing the area under the curve for each trapezoid
output_disc$data
#>         delay value     x_lead y_lead         auc
#> 1  0.01010101  0.82 0.07070707   0.70 0.046060606
#> 2  0.07070707  0.70 0.10101010   0.29 0.015000000
#> 3  0.10101010  0.29 0.11111111   0.83 0.005656566
#> 4  0.11111111  0.83 0.13131313   0.95 0.017979798
#> 5  0.13131313  0.95 0.15151515   0.46 0.014242424
#> 6  0.15151515  0.46 0.17171717   0.81 0.012828283
#> 7  0.17171717  0.81 0.18181818   0.05 0.004343434
#> 8  0.18181818  0.05 0.20202020   0.71 0.007676768
#> 9  0.20202020  0.71 0.21212121   0.25 0.004848485
#> 10 0.21212121  0.25 0.23232323   0.78 0.010404040
#> 11 0.23232323  0.78 0.24242424   0.58 0.006868687
#> 12 0.24242424  0.58 0.27272727   0.94 0.023030303
#> 13 0.27272727  0.94 0.29292929   0.93 0.018888889
#> 14 0.29292929  0.93 0.30303030   0.55 0.007474747
#> 15 0.30303030  0.55 0.33333333   0.12 0.010151515
#> 16 0.33333333  0.12 0.34343434   0.44 0.002828283
#> 17 0.34343434  0.44 0.35353535   0.80 0.006262626
#> 18 0.35353535  0.80 0.37373737   0.31 0.011212121
#> 19 0.37373737  0.31 0.39393939   0.07 0.003838384
#> 20 0.39393939  0.07 0.40404040   0.89 0.004848485
#> 21 0.40404040  0.89 0.45454545   0.90 0.045202020
#> 22 0.45454545  0.90 0.48484848   0.74 0.024848485
#> 23 0.48484848  0.74 0.50505051   0.77 0.015252525
#> 24 0.50505051  0.77 0.53535354   0.24 0.015303030
#> 25 0.53535354  0.24 0.54545455   0.28 0.002626263
#> 26 0.54545455  0.28 0.55555556   0.22 0.002525253
#> 27 0.55555556  0.22 0.56565657   0.90 0.005656566
#> 28 0.56565657  0.90 0.57575758   0.85 0.008838384
#> 29 0.57575758  0.85 0.58585859   0.75 0.008080808
#> 30 0.58585859  0.75 0.63636364   0.26 0.025505051
#> 31 0.63636364  0.26 0.66666667   0.81 0.016212121
#> 32 0.66666667  0.81 0.68686869   0.84 0.016666667
#> 33 0.68686869  0.84 0.70707071   0.63 0.014848485
#> 34 0.70707071  0.63 0.72727273   0.02 0.006565657
#> 35 0.72727273  0.02 0.74747475   1.00 0.010303030
#> 36 0.74747475  1.00 0.77777778   0.35 0.020454545
#> 37 0.77777778  0.35 0.79797980   0.40 0.007575758
#> 38 0.79797980  0.40 0.80808081   0.40 0.004040404
#> 39 0.80808081  0.40 0.81818182   0.55 0.004797980
#> 40 0.81818182  0.55 0.82828283   0.92 0.007424242
#> 41 0.82828283  0.92 0.83838384   0.65 0.007929293
#> 42 0.83838384  0.65 0.90909091   0.21 0.030404040
#> 43 0.90909091  0.21 0.91919192   0.14 0.001767677
#> 44 0.91919192  0.14 0.92929293   1.00 0.005757576
#> 45 0.92929293  1.00 0.94949495   0.57 0.015858586
#> 46 0.94949495  0.57 0.95959596   0.50 0.005404040
#> 47 0.95959596  0.50 0.96969697   0.67 0.005909091
#> 48 0.96969697  0.67 0.98989899   0.39 0.010707071
#> 49 0.98989899  0.39 1.00000000   0.28 0.003383838
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
#> [1] 0.5136

#Get the data frame containing the area under the curve for each trapezoid
output_disc_2$data
#>    delay value delay_lead value_lead     auc
#> 1   0.01  0.51       0.02       0.82 0.00665
#> 2   0.02  0.82       0.09       0.74 0.05460
#> 3   0.09  0.74       0.10       0.64 0.00690
#> 4   0.10  0.64       0.12       0.74 0.01380
#> 5   0.12  0.74       0.13       0.76 0.00750
#> 6   0.13  0.76       0.14       0.24 0.00500
#> 7   0.14  0.24       0.25       0.08 0.01760
#> 8   0.25  0.08       0.27       0.21 0.00290
#> 9   0.27  0.21       0.29       0.45 0.00660
#> 10  0.29  0.45       0.30       0.42 0.00435
#> 11  0.30  0.42       0.31       0.79 0.00605
#> 12  0.31  0.79       0.33       0.63 0.01420
#> 13  0.33  0.63       0.34       0.17 0.00400
#> 14  0.34  0.17       0.36       0.77 0.00940
#> 15  0.36  0.77       0.37       0.11 0.00440
#> 16  0.37  0.11       0.40       0.92 0.01545
#> 17  0.40  0.92       0.41       0.54 0.00730
#> 18  0.41  0.54       0.43       0.72 0.01260
#> 19  0.43  0.72       0.44       0.91 0.00815
#> 20  0.44  0.91       0.45       0.73 0.00820
#> 21  0.45  0.73       0.46       0.99 0.00860
#> 22  0.46  0.99       0.48       0.73 0.01720
#> 23  0.48  0.73       0.49       0.86 0.00795
#> 24  0.49  0.86       0.51       0.53 0.01390
#> 25  0.51  0.53       0.52       0.18 0.00355
#> 26  0.52  0.18       0.55       0.03 0.00315
#> 27  0.55  0.03       0.56       0.58 0.00305
#> 28  0.56  0.58       0.58       0.60 0.01180
#> 29  0.58  0.60       0.59       0.18 0.00390
#> 30  0.59  0.18       0.60       0.23 0.00205
#> 31  0.60  0.23       0.62       0.61 0.00840
#> 32  0.62  0.61       0.64       0.20 0.00810
#> 33  0.64  0.20       0.65       0.74 0.00470
#> 34  0.65  0.74       0.66       0.51 0.00625
#> 35  0.66  0.51       0.68       0.94 0.01450
#> 36  0.68  0.94       0.69       0.47 0.00705
#> 37  0.69  0.47       0.75       0.77 0.03720
#> 38  0.75  0.77       0.76       0.50 0.00635
#> 39  0.76  0.50       0.77       0.25 0.00375
#> 40  0.77  0.25       0.78       0.94 0.00595
#> 41  0.78  0.94       0.79       0.18 0.00560
#> 42  0.79  0.18       0.81       0.56 0.00740
#> 43  0.81  0.56       0.83       0.06 0.00620
#> 44  0.83  0.06       0.87       0.88 0.01880
#> 45  0.87  0.88       0.89       0.90 0.01780
#> 46  0.89  0.90       0.95       0.34 0.03720
#> 47  0.95  0.34       0.96       0.79 0.00565
#> 48  0.96  0.79       0.98       0.20 0.00990
#> 49  0.98  0.20       1.00       1.00 0.01200
```
