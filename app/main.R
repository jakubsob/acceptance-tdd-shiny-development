box::use(
  shiny[
    actionButton,
    bootstrapPage,
    moduleServer,
    NS,
    numericInput,
    observeEvent,
    reactiveVal,
    renderText,
    tagAppendAttributes,
    textOutput,
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
      ),
    textOutput(
      ns("total_income")
    ) |>
      tagAppendAttributes(
        "data-test" = "total-income"
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    total_income <- reactiveVal(0)

    observeEvent(input$record_income, {
      total_income(total_income() + input$income)
    })

    output$total_income <- renderText({
      total_income()
    })
  })
}
