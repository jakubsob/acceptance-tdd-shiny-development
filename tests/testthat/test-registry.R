box::use(
  glue[glue],
  testthat[...], # nolint
  withr[with_tempdir],
)

box::use(
  app / registry,
  app / transaction,
)

# Fake storage
create_storage <- function() {
  .storage <- glue::glue("store_session_{as.numeric(Sys.time())}.csv")
  write.csv(data.frame(amount = numeric()), .storage, row.names = FALSE)
  .storage
}

describe("record", {
  it("should record a transaction", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      .registry$record(transaction$new(100)) # nolint

      # Assert
      expect_equal(nrow(read.csv(.storage)), 1)
    })
  })

  it("should record multiple transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      .registry$record(transaction$new(100)) # nolint
      .registry$record(transaction$new(100)) # nolint

      # Assert
      expect_equal(nrow(read.csv(.storage)), 2)
    })
  })

  it("should throw an error if storage doesn't exist", {
    # Arrange
    with_tempdir({
      .storage <- create_storage()
    })

    # Act, Assert
    expect_error(
      registry$new(.storage),
      regexp = glue("File {.storage} does not exist"),
      fixed = TRUE
    )
  })
})

describe("get_total_positive", {
  it("should return the total of positive transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      .registry$record(transaction$new(100)) # nolint
      .registry$record(transaction$new(-100)) # nolint

      # Assert
      expect_equal(.registry$get_total_positive(), 100)
    })
  })

  it("should return 0 if there are no transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      result <- .registry$get_total_positive()

      # Assert
      expect_equal(result, 0)
    })
  })
})

describe("get_total_negative", {
  it("should return the total of negative transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      .registry$record(transaction$new(200)) # nolint
      .registry$record(transaction$new(-100)) # nolint

      # Assert
      expect_equal(.registry$get_total_negative(), 100)
    })
  })

  it("should return 0 if there are no transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      result <- .registry$get_total_negative()

      # Assert
      expect_equal(result, 0)
    })
  })
})

describe("get_total", {
  it("should return the total of all transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      .registry$record(transaction$new(100)) # nolint
      .registry$record(transaction$new(-100)) # nolint

      # Assert
      expect_equal(.registry$get_total(), 0)
    })
  })

  it("should return 0 if there are no transactions", {
    with_tempdir({
      # Arrange
      .storage <- create_storage()
      .registry <- registry$new(.storage)

      # Act
      result <- .registry$get_total()

      # Assert
      expect_equal(result, 0)
    })
  })
})
