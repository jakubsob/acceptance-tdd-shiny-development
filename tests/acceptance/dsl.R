box::use(
  R6[R6Class],
  rhino,
  selenider,
  shinytest2,
  testthat[...],
  withr[with_dir],
)

AppDriver <- R6Class(
  public = list(
    session = NULL,
    driver = NULL,
    initialize = function(app = rhino$app()) {
      with_dir("../../", {
        self$driver <- shinytest2$AppDriver$new(app)
        self$session <- selenider$selenider_session(
          driver = self$driver,
          local = FALSE
        )
      })
    },
    record_income = function(amount, driver) {
      self$session |>
        selenider$find_element("[data-test='income']") |>
        selenider$elem_set_value(amount)
      self$session |>
        selenider$find_element("[data-test='record-income']") |>
        selenider$elem_click()
    },
    record_expense = function(amount) {
      self$session |>
        selenider$find_element("[data-test='expense']") |>
        selenider$elem_set_value(amount)
      self$session |>
        selenider$find_element("[data-test='record-expense']") |>
        selenider$elem_click()
    },
    verify_total_income = function(amount) {
      self$session |>
        selenider$find_element("[data-test='total-income']") |>
        selenider$elem_text() |>
        as.numeric() |>
        expect_equal(amount)
    }
  )
)

get_driver_factory <- function() {
  driver <- NULL
  function() {
    if (is.null(driver)) {
      driver <<- AppDriver$new()
    }
    driver
  }
}
get_driver <- get_driver_factory()

#' @export
record_income <- function(amount) {
  driver <- get_driver()
  driver$record_income(amount)
}

#' @export
record_expense <- function(amount) {
  driver <- get_driver()
  driver$record_expense(amount)
}

#' @export
inspect_finances <- function() {

}

#' @export
verify_total_income <- function(amount) {
  driver <- get_driver()
  driver$verify_total_income(amount)
}

#' @export
verify_total_expenses <- function(amount) {
  fail("Not implemented")
}

#' @export
verify_net_balance <- function(amount) {
  fail("Not implemented")
}
