box::use(
  testthat[...],
)

box::use(
  tests/acceptance/dsl,
)

# Given I have recorded my income of $2000
# And I have recorded my expenses of $500
# When I inspect my personal finances
# Then I should see my total income as $2000
# And my total expenszes as $500
# And my net balance as $1500
test_that("Scenario: I can inspect my net balance", {
  # Given
  dsl$record_income(2000)
  dsl$record_expense(500)
  # When
  dsl$inspect_finances()
  # Then
  dsl$verify_total_income(2000)
  dsl$verify_total_expenses(500)
  dsl$verify_net_balance(1500)
})
