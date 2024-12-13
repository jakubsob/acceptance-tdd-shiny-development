box::use(
  shiny[
    actionButton,
    bootstrapPage,
    moduleServer,
    NS,
    numericInput,
    tagAppendAttributes,
  ],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    numericInput(
      ns("income"),
      label = "Income",
      value = 0
    ) |>
      tagAppendAttributes(
        .cssSelector = "input",
        "data-test" = "income"
      ),
    actionButton(
      ns("record_income"),
      "Record Income"
    ) |>
      tagAppendAttributes(
        "data-test" = "record-income"
      ),
    numericInput(
      ns("expense"),
      label = "Expense",
      value = 0
    ) |>
      tagAppendAttributes(
        .cssSelector = "input",
        "data-test" = "expense"
      ),
    actionButton(
      ns("record_expense"),
      "Record Expense"
    ) |>
      tagAppendAttributes(
        "data-test" = "record-expense"
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
