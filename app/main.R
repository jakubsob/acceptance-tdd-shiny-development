box::use(
  bslib[
    page_fluid,
  ],
  shiny[
    column,
    fluidRow,
    moduleServer,
    NS,
    observeEvent,
    reactiveVal,
    renderText,
  ],
)

box::use(
  app / components,
  app / registry,
  app / storage,
  app / transaction,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  page_fluid(
    fluidRow(
      column(
        width = 4,
        offset = 4,
        class = "d-flex flex-column gap-2",
        components$form(
          components$numeric_input(
            ns("income"),
            label = "Income",
            value = 0,
            class = "form-control",
            .data_test = "income"
          ),
          components$button(
            ns("record_income"),
            "Record Income",
            .data_test = "record-income"
          )
        ),
        components$form(
          components$numeric_input(
            ns("expense"),
            label = "Expense",
            value = 0,
            class = "form-control",
            .data_test = "expense"
          ),
          components$button(
            ns("record_expense"),
            "Record Expense",
            .data_test = "record-expense"
          )
        ),
        components$value_card(
          "Total Income",
          components$text_output(
            ns("total_income"),
            .data_test = "total-income"
          )
        ),
        components$value_card(
          "Total Expenses",
          components$text_output(
            ns("total_expenses"),
            .data_test = "total-expenses"
          )
        ),
        components$value_card(
          "Net Balance",
          components$text_output(
            ns("net_balance"),
            .data_test = "net-balance"
          )
        )
      )
    )
  )
}

#' @export
server <- function(
    id,
    .storage = storage$new(
      getOption("storage.path", "store.csv"),
      getOption("storage.schema", transaction$new())
    )) {
  moduleServer(id, function(input, output, session) {
    .registry <- registry$new(.storage)
    has_registry_updated <- reactiveVal(0)

    observeEvent(input$record_income, {
      .registry$record(transaction$new(input$income)) # nolint
      has_registry_updated(has_registry_updated() + 1)
    })

    observeEvent(input$record_expense, {
      .registry$record(transaction$new(-input$expense)) # nolint
      has_registry_updated(has_registry_updated() + 1)
    })

    output$total_income <- renderText({
      has_registry_updated()
      .registry$get_total_positive()
    })

    output$total_expenses <- renderText({
      has_registry_updated()
      .registry$get_total_negative()
    })

    output$net_balance <- renderText({
      has_registry_updated()
      .registry$get_total()
    })
  })
}
