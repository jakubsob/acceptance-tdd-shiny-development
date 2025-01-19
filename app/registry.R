box::use(
  dplyr[filter, pull, summarise],
  fs[file_exists, path_ext],
  glue[glue],
  R6[R6Class],
  rlang[abort],
  utils[read.csv, write.table],
)

#' @export
new <- function(x, ...) {
  UseMethod("new")
}

registry_csv <- R6Class(
  private = list(
    storage = NULL
  ),
  public = list(
    initialize = function(storage) {
      private$storage <- storage
    },
    record = function(transaction) {
      write.table(
        data.frame(amount = transaction$amount),
        private$storage,
        row.names = FALSE,
        col.names = FALSE,
        append = TRUE
      )
    },
    get_total_positive = function() {
      transactions <- read.csv(private$storage)
      transactions |>
        filter(amount > 0) |>
        summarise(total = sum(amount)) |>
        pull(total)
    },
    get_total_negative = function() {
      transactions <- read.csv(private$storage)
      transactions |>
        filter(amount < 0) |>
        summarise(total = -sum(amount)) |>
        pull(total)
    },
    get_total = function() {
      transactions <- read.csv(private$storage)
      transactions |>
        summarise(total = sum(amount)) |>
        pull(total)
    }
  )
)

#' @export
new.character <- function(x, ...) {
  if (!file_exists(x)) {
    abort(glue("File {x} does not exist"))
  }

  switch(path_ext(x),
    csv = registry_csv$new(x),
    abort(glue("Unsupported file extension: {path_ext(x)}"))
  )
}
