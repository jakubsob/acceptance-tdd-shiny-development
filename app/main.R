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
      ),
    textOutput(
      ns("total_expenses")
    ) |>
      tagAppendAttributes(
        "data-test" = "total-expenses"
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    total_income <- reactiveVal(0)
    total_expenses <- reactiveVal(0)

    observeEvent(input$record_income, {
      total_income(total_income() + input$income)
    })

    observeEvent(input$record_expense, {
      total_expenses(total_expenses() + input$expense)
    })

    output$total_income <- renderText({
      total_income()
    })

    output$total_expenses <- renderText({
      total_expenses()
    })
  })
}
