context("infoboxes_appears")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)

connectionObj$open(silent = TRUE)

patrick::with_parameters_test_that("InfoBoxes rendered in Data Summary >> ", {
    connectionObj$navigate(helper_app_url)
    Sys.sleep(8)
    
    ## Reduce sample size
    sampleSize <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-recordSize")
    sampleSize$clearElement()
    sampleSize$sendKeysToElement(list(sample_size_param))
    Sys.sleep(2)
    
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
    
    dataSummaryTab <- connectionObj$findElement(using = "xpath",
                                                value = "/html/body/div[1]/aside/section/ul/li[2]/ul/li[1]/a")
    dataSummaryTab$clickElement()
    Sys.sleep(5)
    
    ## Open one of Spatial / Temporal / Taxonomic SubTab
    subTabButton <- connectionObj$findElement(using = "id",
                                              value = subtab_id_param)
    subTabButton$clickElement()
    Sys.sleep(5)
    
    ## Collecting all infoBoxes on the current page
    infoBoxesOnPage <- connectionObj$findElements(using = "class name",
                                                  value = "col-sm-4")
    infoBox1 <- FALSE
    infoBox2 <- FALSE
    infoBox3 <- FALSE
  
    infoBoxVector <- unlist(lapply(infoBoxesOnPage, function(x) {x$getElementText()[[1]]}))
    error_validation_string <- "No appropriate Column found"
    
    for(infoBoxText in infoBoxVector) {
      if(grepl(info_box_text_param_1, infoBoxText) | grepl(msg_param_1, infoBoxText)) {
        infoBox1 <- TRUE
      }
      else if(grepl(info_box_text_param_2, infoBoxText) | grepl(msg_param_2, infoBoxText)) {
        infoBox2 <- TRUE
      } 
      else if(grepl(info_box_text_param_3, infoBoxText) | grepl(msg_param_3, infoBoxText)) {
        infoBox3 <- TRUE
      }
    }
    
    ## Expectations: 
    expect_true(infoBox1)
    expect_true(infoBox2)
    expect_true(infoBox3)
  },
  cases(
    gbif_spatial = list(sample_size_param = "100",
                        dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[1]/label/span",
                        subtab_id_param = "data_summary_ui_1-patients",
                        info_box_text_param_1 = "of Geo",
                        info_box_text_param_2 = "of Countries",
                        info_box_text_param_3 = "of Localities",
                        msg_param_1 = spatial_geo_error,
                        msg_param_2 = spatial_country_error,
                        msg_param_3 = spatial_locality_error),
    gbif_temporal = list(sample_size_param = "100",
                         dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[1]/label/span",
                         subtab_id_param = "data_summary_ui_1-antimicrobials",
                         info_box_text_param_1 = "of Years",
                         info_box_text_param_2 = "of Months",
                         info_box_text_param_3 = "of Days",
                         msg_param_1 = temporal_year_error,
                         msg_param_2 = temporal_month_error,
                         msg_param_3 = temporal_day_error),
    gbif_taxonomic = list(sample_size_param = "100",
                          dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[1]/label/span",
                          subtab_id_param = "data_summary_ui_1-diagnostics",
                          info_box_text_param_1 = "of Scientific Name",
                          info_box_text_param_2 = "of Kingdom",
                          info_box_text_param_3 = "of Family",
                          msg_param_1 = taxonomic_name_error,
                          msg_param_2 = taxonomic_kingdom_error,
                          msg_param_3 = taxonomic_family_error),
    bison_spatial = list(sample_size_param = "200",
                        dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span",
                        subtab_id_param = "data_summary_ui_1-patients",
                        info_box_text_param_1 = "of Geo",
                        info_box_text_param_2 = "of Countries",
                        info_box_text_param_3 = "of Localities",
                        msg_param_1 = spatial_geo_error,
                        msg_param_2 = spatial_country_error,
                        msg_param_3 = spatial_locality_error),
    bison_temporal = list(sample_size_param = "200",
                          dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span",
                          subtab_id_param = "data_summary_ui_1-antimicrobials",
                          info_box_text_param_1 = "of Years",
                          info_box_text_param_2 = "of Months",
                          info_box_text_param_3 = "of Days",
                          msg_param_1 = temporal_year_error,
                          msg_param_2 = temporal_month_error,
                          msg_param_3 = temporal_day_error),
    bison_taxonomic = list(sample_size_param = "200",
                          dataset_xpath_param = "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span",
                          subtab_id_param = "data_summary_ui_1-diagnostics",
                          info_box_text_param_1 = "of Scientific Name",
                          info_box_text_param_2 = "of Kingdom",
                          info_box_text_param_3 = "of Family",
                          msg_param_1 = taxonomic_name_error,
                          msg_param_2 = taxonomic_kingdom_error,
                          msg_param_3 = taxonomic_family_error)
  )
)
