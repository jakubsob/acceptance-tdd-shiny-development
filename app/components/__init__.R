box::use(
  shiny[
    actionButton,
    tagAppendAttributes,
    tags,
    textOutput,
  ],
)

#' @export
form <- function(...) {
  tags$div(
    class = "input-group",
    ...
  )
}

#' @export
value_card <- function(label, value) {
  tags$div(
    class = "card",
    tags$div(
      class = "card-body",
      tags$h5(
        class = "card-title",
        label
      ),
      tags$p(
        class = "card-text",
        value
      )
    )
  )
}

#' @export
numeric_input <- function(id, label, value, class = NULL, .data_test = "") {
  tags$input(
    id = id,
    type = "number",
    class = class,
    value = value,
    "data-test" = .data_test
  )
}

#' @export
button <- function(id, label, .data_test = "") {
  actionButton(
    id,
    label = label
  ) |>
    tagAppendAttributes("data-test" = .data_test) |>
    tagAppendAttributes("class" = "btn btn-outline") |>
    tagAppendAttributes("style" = "width: 200px")
}

#' @export
text_output <- function(id, .data_test = "") {
  textOutput(id) |>
    tagAppendAttributes("data-test" = .data_test)
}
