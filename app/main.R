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
      )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
