## To test this file use:
# testthat::test_file("./tests/testthat/test-load_dataset_ALA.R")

context("load_dataset")

library("testthat")
library("RSelenium")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)

testthat::test_that("Data loads up properly", {
  ## Common Area
  connectionObj$navigate(helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  sampleSize <- connectionObj$findElement(using = "id", 
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list("100"))
  Sys.sleep(2)
  
  ## Change search term
  searchTerm <- connectionObj$findElement(using = "id",
                                          value = "bdFileInput-scientificName")
  searchTerm$clearElement()
  searchTerm$sendKeysToElement(list("Amanita pumatona"))
  
  ## Expectation 1
  ALAButton <- connectionObj$findElement(using = "xpath",
                                           value = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[7]/label/span")
  ALAButton$clickElement()
  
  Sys.sleep(5)
  
  uploadButton <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-queryDatabase")
  uploadButton$clickElement()
  
  Sys.sleep(1)
  alertBox <- connectionObj$findElement(using = "class name",
                                        value = "shiny-notification-content-text")
  alertBoxText <- alertBox$getElementText()[[1]]
  print(alertBoxText)
  print(alertBoxText == "")
  
  ## Expectation 2
  Sys.sleep(10)
  
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
  
  alertBoxFound <- FALSE
  if(alertBoxText == "" | alertBoxText == "Read Data Successfully" | alertBoxText == "Querying ala ...") {
    alertBoxFound <- TRUE
  }
  
  ## Expectations
  expect_true(alertBoxFound)
  expect_true(isPopulated)
  expect_true(isTableViewTextMatching)
  
  connectionObj$close()
})
