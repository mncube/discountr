#Create data frame with successive delays and subjective values
df_test <- data.frame(delay = sample(1:100, 50, replace = FALSE),
                      value = sample(1:100, 50, replace = TRUE))

#Normalize data in preparation for auc calculation
df_test$delay <- df_test$delay/max(df_test$delay)
df_test$value <- df_test$value/max(df_test$value)

#Convert data frame to trapezoidal format
df_test_2 <- traper(df_test, x = delay, y = value, rename = TRUE)

#Initialize vectors to collect data from loop
 x_orig <- vector(length=length(df_test_2) - 1)
 x_lead <- vector(length=length(df_test_2) - 1)
 y_orig <- vector(length=length(df_test_2) - 1)
 y_lead <- vector(length=length(df_test_2) - 1)

#Collect original and lead values in vectors
for(i in 1:(nrow(df_test_2) - 1)){
  x_orig[i] <- df_test_2$delay[[i + 1]]
  x_lead[i] <- df_test_2$delay_lead[[i]]
  y_orig[i] <- df_test_2$value[[i + 1]]
  y_lead[i] <- df_test_2$value_lead[[i]]
}

#Run tests
test_that("original x value from next line equals lead x value from current line", {
  expect_equal(x_orig, x_lead)
})

test_that("original y value from next line equals lead y value from current line", {
  expect_equal(y_orig, y_lead)
})
