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
  sec_wait_after_upload_click = 15
  sec_wait_after_overview_click = 2
  
  ## Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  ## Data Overview >> Data Summary
  helper_navigate_missing_data_tab(connectionObj, sec_wait_after_overview_click)
  Sys.sleep(5)
  
  ## Business Logic 
  
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
                dataset_param = "gbif",
                last_test_param = FALSE),
    bison = list(sample_size_param = "200",
                 search_term_param = "Puma concolor",
                 dataset_param = "bison",
                 last_test_param = TRUE)
  )
)