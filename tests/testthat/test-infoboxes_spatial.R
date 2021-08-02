context("infoboxes_appears")

library("testthat")
library("RSelenium")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)

test_that("check infoboxes in Data Summary >> spatial tab", {
  connectionObj$navigate(helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  sampleSize <- connectionObj$findElement(using = "id", 
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list("100"))
  Sys.sleep(2)
  
  datasetButton <- connectionObj$findElement(using = "xpath",
                                             value = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span")
  datasetButton$clickElement()
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
  #"data_summary_ui_1-antimicrobials"
  spatialButton <- connectionObj$findElement(using = "id",
                                             value = "data_summary_ui_1-patients")
  spatialButton$clickElement()
  Sys.sleep(5)
  
  infoBoxesOnPage <- connectionObj$findElements(using = "class name",
                                                value = "col-sm-4")
  
  geoBox <- FALSE
  countriesBox <- FALSE
  localitiesBox <- FALSE
  
  
  infoBoxVector <<- unlist(lapply(infoBoxesOnPage, function(x) {x$getElementText()[[1]]}))
  print(infoBoxVector[6])
  error_validation_string <- "No appropriate Column found "
  print(error_validation_string)
  
  for(i in infoBoxVector) {
    if(grepl("of Geo", i) | grepl(error_validation_string, i)) {
      geoBox <- TRUE
    }
    else if(grepl("of Countries", i) | grepl(error_validation_string, i)) {
      countriesBox <- TRUE
    }
    else if( grepl(error_validation_string, i) | grepl("of Localities", i)) {
      localitiesBox <- TRUE
    }
  }
  
  expect_true(TRUE)
  expect_true(geoBox)
  expect_true(countriesBox)
  expect_true(localitiesBox)
})