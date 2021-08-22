## To test this file use:
# testthat::test_file("./tests/testthat/test-load_dataset_gbif.R")

## This option is kinda messed up!!

context("load_dataset")

library("testthat")
library("RSelenium")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444,
  browserName = "chrome"
)

connectionObj$open(silent = TRUE)

testthat::test_that("Data loads up properly", {
  ## Common Area
  connectionObj$navigate("http://127.0.0.1:7886")
  Sys.sleep(8)
  
  ## Expectation 1
  iDigBioButton <- connectionObj$findElement(using = "xpath",
                                             value = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[3]/label/span")
  iDigBioButton$clickElement()
  
  Sys.sleep(5)
  uploadButton <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-queryDatabase")
  uploadButton$clickElement()
  
  Sys.sleep(2)
  alertBox <- connectionObj$findElement(using = "class name",
                                        value = "shiny-notification-content-text")
  alertBoxText <- alertBox$getElementText()[[1]]
  
  ## Expectation 2
  Sys.sleep(30)
  
  map_svg_class <- connectionObj$findElement(using = "class name",
                                             value = "leaflet-zoom-animated")
  
  isPopulated <- FALSE
  if(map_svg_class$javascript) {
    isPopulated <- TRUE
  }
  
  
  ## Expectation 3
  linksOnPage <- connectionObj$findElements(using = 'css selector', "a")
  #lapply(linksOnPage, function(x) {print(x$getElementText()[[1]])})
  tableView <- linksOnPage[[12]]$clickElement()
  
  Sys.sleep(10)
  
  tableViewTextObj <- connectionObj$findElement(using = "class name",
                                                value = "dataTables_info")
  tableViewText <- tableViewTextObj$getElementText()[[1]]
  isTableViewTextMatching <- FALSE
  if(grepl(pattern = "Showing 1 to", x = tableViewText)) {
    isTableViewTextMatching <- TRUE
  }
  
  ## Expectations
  expect_equal(alertBoxText, "Querying idigbio ...")
  expect_true(isPopulated)
  expect_true(isTableViewTextMatching)
  
  connectionObj$close()
})
