box::use(
  shiny[
    bootstrapPage,
    moduleServer,
    NS,
    observeEvent,
    reactiveVal,
    renderText,
  ],
)

box::use(
  app / components,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    components$numeric_input(
      ns("income"),
      label = "Income",
      value = 0,
      .data_test = "income"
    ),
    components$button(
      ns("record_income"),
      "Record Income",
      .data_test = "record-income"
    ),
    components$numeric_input(
      ns("expense"),
      label = "Expense",
      value = 0,
      .data_test = "expense"
    ),
    components$button(
      ns("record_expense"),
      "Record Expense",
      .data_test = "record-expense"
    ),
    components$text_output(
      ns("total_income"),
      .data_test = "total-income"
    ),
    components$text_output(
      ns("total_expenses"),
      .data_test = "total-expenses"
    ),
    components$text_output(
      ns("net_balance"),
      .data_test = "net-balance"
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

    output$net_balance <- renderText({
      total_income() - total_expenses()
    })
  })
}
