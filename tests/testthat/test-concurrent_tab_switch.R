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
    
    ## Business Logic
    isSpatialUpperSelected <- FALSE
    isSpatialLowerSelected <- FALSE
    spatialUpperTab <- connectionObj$findElement(using = "xpath",
                                                 value = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[1]")
    spatialUpperTabLink <- spatialUpperTab$findChildElements(using = "css selector",
                                                             value = "a")
    
    spatialLowerTab <- connectionObj$findElement(using = "xpath",
                                                 value = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[1]")
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
                                                  value = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[2]")
    temporalUpperTabLink <- temporalUpperTab$findChildElements(using = "css selector",
                                                               value = "a")

    temporalLowerTab <- connectionObj$findElement(using = "xpath",
                                                  value = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[2]")
    temporalLowerTabLink <- temporalLowerTab$findChildElements(using = "css selector",
                                                              value = "a")
    temporalLowerTab$clickElement()

    lapply(temporalLowerTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTemporalLowerSelected <<- TRUE})
    lapply(temporalUpperTabLink, function(x){if(x$getElementAttribute("aria-selected")[[1]] == "true") isTemporalUpperSelected <<- TRUE})


    # if(temporalLowerTabLink[[1]]$getElementAttribute("aria-selected") == "true") {
    #   print("Yo!!")
    #   isTemporalLowerSelected <- TRUE
    # }
    # 
    # if(temporalUpperTabLink[[1]]$getElementAttribute("aria-selected") == "true") {
    #   isTemporalUpperSelected <- TRUE
    # }
    # 
    # print(isTemporalLowerSelected)
    # print(isTemporalUpperSelected)

    # ##taxonomic
    isTaxonomicUpperSelected <- FALSE
    isTaxonomicLowerSelected <- FALSE

    taxonomicUpperTab <- connectionObj$findElement(using = "xpath",
                                                   value = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[3]")
    taxonomicUpperTabLink <- taxonomicUpperTab$findChildElements(using = "css selector",
                                                                 value = "a")

    taxonomicLowerTab <- connectionObj$findElement(using = "xpath",
                                                   value = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[3]")
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
                dataset_xpath_param = helper_gbif_xpath,
                last_test = FALSE),
    bison = list(sample_size_param = "200",
                 search_term_param = "Puma concolor",
                 dataset_xpath_param = helper_bison_xpath,
                 last_test = TRUE)
  )
)