#Create data frame with successive delays and subjective values
df_test <- data.frame(delay = sample(1:100, 50, replace = FALSE),
                      value = sample(1:100, 50, replace = TRUE))

#Normalize data in preparation for auc calculation
df_test$delay <- df_test$delay/max(df_test$delay)
df_test$value <- df_test$value/max(df_test$value)

#Reformat data in preparation to compute the trapezoidal auc
df_test_2 <- traper(df_test, x = delay, y = value, rename = TRUE)

#Calculate the area under the curve explicitly defining x_lead and y_lead
output_test_A <- trap_auc(df_test_2, x = delay, y = value,
                          x_lead = delay_lead, y_lead = value_lead)
#Get area under the curve
output_test_A$total

#Calculate the area under the curve without explicitly defining x_lead and y_lead
output_test_B <- trap_auc(df_test, x = delay, y = value)

#Run test
test_that("Total area under the curve is the same whether or not x_lead and
           y_lead are explicitly entered into the model", {
  expect_equal(output_test_A$total, output_test_B$total)
})
