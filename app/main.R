box::use(
  shiny[
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
    numericInput(
      ns("expense"),
      label = "Expense",
      value = 0
    ) |>
      tagAppendAttributes(
        .cssSelector = "input",
        "data-test" = "expense"
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
