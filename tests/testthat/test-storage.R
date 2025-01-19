box::use(
  fs[file_exists],
  testthat[...], # nolint
  withr[with_tempdir],
)

box::use(
  app / storage,
)

describe("new", {
  it("should create a new csv storage if csv path is provided", {
    with_tempdir({
      # Arrange
      path <- "store.csv"

      # Act
      .storage <- storage$new(path, schema = list(amount = numeric()))

      # Assert
      expect_true(file_exists(.storage))
    })
  })
})
