#' @export
new <- function(amount = numeric(), ...) {
  structure(
    list(amount = amount),
    class = "transaction"
  )
}
