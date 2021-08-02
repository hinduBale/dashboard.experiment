## To test this file use:
# testthat::test_file("./tests/testthat/test-render_gauge_plot.R")

context("gauge_plot_appears")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)
patrick::with_parameters_test_that("Gauge Plots are rendered: ", {
  connectionObj$navigate(helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  sampleSize <- connectionObj$findElement(using = "id",
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list(sample_size_param))
  Sys.sleep(2)
  
  ## Change search term
  searchTerm <- connectionObj$findElement(using = "id",
                                          value = "bdFileInput-scientificName")
  searchTerm$clearElement()
  searchTerm$sendKeysToElement(list(search_term_param))
  
  ## Select online dataset
  datasetButton <- connectionObj$findElement(using = "xpath",
                                             value = dataset_xpath_param)
  datasetButton$clickElement()
  Sys.sleep(2)
  
  ## Click on the queryDatabase button
  uploadButton <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-queryDatabase")
  uploadButton$clickElement()
  Sys.sleep(15)
  
  ## Click on the Perform Header Cleaning Button
  darwianizeButton <- connectionObj$findElement(using = "id",
                                                value = "darwinize-darwinizeButton")
  darwianizeButton$clickElement()
  Sys.sleep(8)
  
  ## Data Overview >> Data Summary
  dataOverviewTab <- connectionObj$findElement(using = "xpath",
                                               value = "/html/body/div[1]/aside/section/ul/li[2]/a/span")
  dataOverviewTab$clickElement()
  Sys.sleep(2)
  
  missingDataTab <- connectionObj$findElement(using = "xpath",
                                              value = "/html/body/div[1]/aside/section/ul/li[2]/ul/li[2]/a")
  missingDataTab$clickElement()
  Sys.sleep(5)
  
  isGauge1 <- FALSE
  isGauge2 <- FALSE
  isGauge3 <- FALSE
  isGauge4 <- FALSE
  
  gauge1 <- connectionObj$findElement(using = "id",
                                      value = "missing_data_ui_1-gauge_one")
  if(grepl("% of georeferenced records",gauge1$getElementText())) {
    isGauge1 <- TRUE
  }
  
  gauge2 <- connectionObj$findElement(using = "id",
                                      value = "missing_data_ui_1-gauge_two")
  if(grepl("% of recordswith date data",gauge2$getElementText())) {
    #print(gauge2$getElementText())
    isGauge2 <- TRUE
  }
  
  gauge3 <- connectionObj$findElement(using = "id",
                                      value = "missing_data_ui_1-gauge_three")
  #print(gauge3$getElementText())
  if(grepl("% of recordswith occurence remark/link",gauge3$getElementText())) {
    #print(gauge3$getElementText())
    isGauge3 <- TRUE
  }
  
  gauge4 <- connectionObj$findElement(using = "id",
                                      value = "missing_data_ui_1-gauge_four")
  #print(gauge4$getElementText())
  if(grepl("% of recordswith basisOfRecord data",gauge4$getElementText())) {
    #print(gauge4$getElementText())
    isGauge4 <- TRUE
  }
  
  #expect_true(TRUE)
  expect_true(isGauge1)
  expect_true(isGauge2)
  expect_true(isGauge3)
  expect_true(isGauge4)
  },
  cases(
    gbif = list(sample_size_param = "200",
                search_term_param = "Puma concolor",
                dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[1]/label/span"),
    bison = list(sample_size_param = "200",
                 search_term_param = "Puma concolor",
                 dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span")
  )
)

## Make tests supplier-independent
## Go through the gauge-generation code
##Suggested Parameters:
## 1. Record Filter: Without Cordinates
## Step1. Normal condition
## Step2. Unexpected scenario with expected behaviour (Abnormal behavior)
## Step3. Very unique (Edge) cases (Generate ideas)