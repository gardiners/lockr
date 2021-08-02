test_that("URL constructed", {
  base <- "https://foo.bar/api/"

  expect_equal(make_url(base, "status"),
               "https://foo.bar/api/?NOAUTH=&type=module&prefix=locking_api&page=status")
  expect_error(make_url(base, action = c("lock", "unlock")))
  expect_error(make_url("foo.bar/api", action = "lock"))
  expect_warning(make_url("https://foo.bar", action = "lock"))
}
)
