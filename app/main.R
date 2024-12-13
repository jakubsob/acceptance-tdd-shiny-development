box::use(
  shiny[
    bootstrapPage,
    moduleServer,
    NS,
  ],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage()
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
