box::use(
  shiny[
    actionButton,
    numericInput,
    tagAppendAttributes,
    textOutput,
  ],
)

#' @export
numeric_input <- function(id, label, value, .data_test = "") {
  numericInput(
    id,
    label = label,
    value = value
  ) |>
    tagAppendAttributes(.cssSelector = "input", "data-test" = .data_test)
}

#' @export
button <- function(id, label, .data_test = "") {
  actionButton(
    id,
    label = label
  ) |>
    tagAppendAttributes("data-test" = .data_test)
}

#' @export
text_output <- function(id, .data_test = "") {
  textOutput(id) |>
    tagAppendAttributes("data-test" = .data_test)
}
