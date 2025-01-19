box::use(
  fs[file_exists, path_ext],
  glue[glue],
  rlang[abort],
  tibble[tibble],
  utils[write.csv],
)

new_storage <- function(x, ...) {
  UseMethod("new_storage")
}

new_storage.character <- function(x, ...) { # nolint
  switch(path_ext(x),
    csv = storage_csv(x, ...),
    abort(glue("Unsupported file extension: {path_ext(x)}"))
  )
}

storage_csv <- function(x, schema) {
  if (!file_exists(x)) {
    write.csv(tibble(!!!schema), x, row.names = FALSE)
  }
  x
}

#' @export
new <- new_storage
