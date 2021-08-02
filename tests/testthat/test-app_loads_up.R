context("app_loads_up")

library("testthat")
library("RSelenium")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)

test_that("check connection", {
  connectionObj$navigate(helper_app_url)
  appTitle <- connectionObj$getTitle()[[1]]
  # print(connectionObj$getTitle())
  expect_equal(appTitle, "dashboard.experiment")
  # Add this line to the last test of a file
  connectionObj$close()
})

