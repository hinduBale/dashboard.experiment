## To test this file use:
# testthat::test_file("./tests/testthat/test-concurrent_tab_switch.R")

context("concurrent_tab_switch_happens")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)


connectionObj$open(silent = TRUE)
patrick::with_parameters_test_that("Concurrent Tab Switches Take Place: ", {
  
  sec_wait_after_upload_click = 15
  sec_wait_after_overview_click = 2
  
  # Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  # Navigate to the test site: Data Overview >> Data Summary
  helper_navigate_missing_data_tab(connectionObj, sec_wait_after_overview_click)
  Sys.sleep(5)
  
  ## Business Logic
  
  ##spatial
  isSpatialUpperSelected <- FALSE
  isSpatialLowerSelected <- FALSE
  spatialUpperTab <- connectionObj$findElement(using = "xpath",
                                               value = helper_spatial_upper_tab_xpath)
  spatialUpperTabLink <- spatialUpperTab$findChildElements(using = "css selector",
                                                           value = "a")
  
  spatialLowerTab <- connectionObj$findElement(using = "xpath",
                                               value = helper_spatial_lower_tab_xpath)
  spatialLowerTabLink <- spatialLowerTab$findChildElements(using = "css selector",
                                                           value = "a")
  if(spatialLowerTabLink[[1]]$getElementAttribute("aria-selected") == "true") {
    isSpatialLowerSelected <- TRUE
  }
  
  if(spatialUpperTabLink[[1]]$getElementAttribute("aria-selected") == "true") {
    isSpatialUpperSelected <- TRUE
  }
  
  # #temporal
  isTemporalUpperSelected <- FALSE
  isTemporalLowerSelected <- FALSE

  temporalUpperTab <- connectionObj$findElement(using = "xpath",
                                                value = helper_temporal_upper_tab_xpath)
  temporalUpperTabLink <- temporalUpperTab$findChildElements(using = "css selector",
                                                             value = "a")

  temporalLowerTab <- connectionObj$findElement(using = "xpath",
                                                value = helper_temporal_lower_tab_xpath)
  temporalLowerTabLink <- temporalLowerTab$findChildElements(using = "css selector",
                                                            value = "a")
  temporalLowerTab$clickElement()

  lapply(temporalLowerTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTemporalLowerSelected <<- TRUE})
  lapply(temporalUpperTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTemporalUpperSelected <<- TRUE})

  # ##taxonomic
  isTaxonomicUpperSelected <- FALSE
  isTaxonomicLowerSelected <- FALSE

  taxonomicUpperTab <- connectionObj$findElement(using = "xpath",
                                                 value = helper_taxonomic_upper_tab_xpath)
  taxonomicUpperTabLink <- taxonomicUpperTab$findChildElements(using = "css selector",
                                                               value = "a")

  taxonomicLowerTab <- connectionObj$findElement(using = "xpath",
                                                 value = helper_taxonomic_lower_tab_xpath)
  taxonomicLowerTabLink <- taxonomicLowerTab$findChildElements(using = "css selector",
                                                               value = "a")
  taxonomicUpperTab$clickElement()
  
  lapply(taxonomicLowerTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTaxonomicLowerSelected <<- TRUE})
  lapply(taxonomicUpperTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTaxonomicUpperSelected <<- TRUE})
  
  # Expectations
  #expect_true(TRUE)
  expect_true(isSpatialLowerSelected & isSpatialUpperSelected)
  expect_true(isTemporalLowerSelected & isTemporalUpperSelected)
  expect_true(isTaxonomicLowerSelected & isTaxonomicUpperSelected)

  if(last_test) {
    connectionObj$close()   
  }
  },
  cases(
    gbif = list(sample_size_param = "200",
                search_term_param = "Puma concolor",
                dataset_param = "gbif",
                last_test = FALSE),
    bison = list(sample_size_param = "200",
                 search_term_param = "Puma concolor",
                 dataset_param = "bison",
                 last_test = TRUE)
  )
)