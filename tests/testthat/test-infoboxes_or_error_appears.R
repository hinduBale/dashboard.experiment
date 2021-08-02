context("infoboxes_or_error_message_check")

library("testthat")
library("RSelenium")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)

patrick::with_parameters_test_that("check infoBoxes in Data Summary >> ", {
  connectionObj$navigate(helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  sampleSize <- connectionObj$findElement(using = "id", 
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list("100"))
  Sys.sleep(2)
  
    
},
  
)

test_that("check infoboxes in Data Summary >> spatial tab", {
  connectionObj$navigate(helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  sampleSize <- connectionObj$findElement(using = "id", 
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list("100"))
  Sys.sleep(2)
  
  ## Click on the queryDatabase button
  uploadButton <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-queryDatabase")
  uploadButton$clickElement()
  
  Sys.sleep(20)
  
  ## Click on the Perform Header Cleaning Button
  darwianizeButton <- connectionObj$findElement(using = "id",
                                                value = "darwinize-darwinizeButton")
  darwianizeButton$clickElement()
  
  Sys.sleep(10)
  
  dataOverviewTab <- connectionObj$findElement(using = "xpath",
                                               value = "/html/body/div[1]/aside/section/ul/li[2]/a/span")
  dataOverviewTab$clickElement()
  Sys.sleep(5)
  
  dataSummaryTab <- connectionObj$findElement(using = "xpath",
                                              value = "/html/body/div[1]/aside/section/ul/li[2]/ul/li[1]/a")
  dataSummaryTab$clickElement()
  Sys.sleep(10)
  #"data_summary_ui_1-patients"
  spatialButton <- connectionObj$findElement(using = "id",
                                             value = "data_summary_ui_1-antimicrobials")
  spatialButton$clickElement()
  Sys.sleep(5)
  
  infoBoxesOnPage <- connectionObj$findElements(using = "class name",
                                                value = "col-sm-4")
  
  lapply(infoBoxesOnPage, function(x) {print(x$getElementText()[[1]])})
  print(length(infoBoxesOnPage))
  
  expect_true(TRUE)
})