## To test this file, type:
# testthat::test_file("./tests/testthat/test-infoboxes_or_messages_param.R")

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
      
    sec_wait_after_upload_click = 15
    sec_wait_after_overview_click = 2
    
    # Prepare dataset for test
    helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                    search_term_param, dataset_param, sec_wait_after_upload_click)
    Sys.sleep(8)
      
    ## Data Overview >> Data Summary
    helper_navigate_data_summary_tab(connectionObj, sec_wait_after_overview_click)
      
    ## Navigate sub tabs
    helper_navigate_subtabs(connectionObj, tabName_param)
    
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
                        search_term_param = "Puma concolor",
                        dataset_param = "gbif",
                        tabName_param = "spatial",
                        info_box_text_param_1 = helper_spatial_subTab_infoBox1_text,
                        info_box_text_param_2 = helper_spatial_subTab_infoBox2_text,
                        info_box_text_param_3 = helper_spatial_subTab_infoBox3_text,
                        msg_param_1 = spatial_geo_error,
                        msg_param_2 = spatial_country_error,
                        msg_param_3 = spatial_locality_error),
    gbif_temporal = list(sample_size_param = "100",
                        search_term_param = "Puma concolor",
                         dataset_param = "gbif",
                         tabName_param = "temporal",
                         info_box_text_param_1 = helper_temporal_subTab_infoBox1_text,
                         info_box_text_param_2 = helper_temporal_subTab_infoBox2_text,
                         info_box_text_param_3 = helper_temporal_subTab_infoBox3_text,
                         msg_param_1 = temporal_year_error,
                         msg_param_2 = temporal_month_error,
                         msg_param_3 = temporal_day_error),
    gbif_taxonomic = list(sample_size_param = "100",
                          search_term_param = "Puma concolor",
                          dataset_param = "gbif",
                          tabName_param = "taxonomic",
                          info_box_text_param_1 = helper_taxonomic_subTab_infoBox1_text,
                          info_box_text_param_2 = helper_taxonomic_subTab_infoBox2_text,
                          info_box_text_param_3 = helper_taxonomic_subTab_infoBox3_text,
                          msg_param_1 = taxonomic_name_error,
                          msg_param_2 = taxonomic_kingdom_error,
                          msg_param_3 = taxonomic_family_error),
    bison_spatial = list(sample_size_param = "200",
                         search_term_param = "Puma concolor",
                         dataset_param = "bison",
                        tabName_param = "spatial",
                        info_box_text_param_1 = helper_spatial_subTab_infoBox1_text,
                        info_box_text_param_2 = helper_spatial_subTab_infoBox2_text,
                        info_box_text_param_3 = helper_spatial_subTab_infoBox3_text,
                        msg_param_1 = spatial_geo_error,
                        msg_param_2 = spatial_country_error,
                        msg_param_3 = spatial_locality_error),
    bison_temporal = list(sample_size_param = "200",
                          search_term_param = "Puma concolor",
                          dataset_param = "bison",
                          tabName_param = "temporal",
                          info_box_text_param_1 = helper_temporal_subTab_infoBox1_text,
                          info_box_text_param_2 = helper_temporal_subTab_infoBox2_text,
                          info_box_text_param_3 = helper_temporal_subTab_infoBox3_text,
                          msg_param_1 = temporal_year_error,
                          msg_param_2 = temporal_month_error,
                          msg_param_3 = temporal_day_error),
    bison_taxonomIc = list(sample_size_param = "200",
                           search_term_param = "Puma concolor",
                           dataset_param = "bison",
                          tabName_param = "taxonomic",
                          info_box_text_param_1 = helper_taxonomic_subTab_infoBox1_text,
                          info_box_text_param_2 = helper_taxonomic_subTab_infoBox2_text,
                          info_box_text_param_3 = helper_taxonomic_subTab_infoBox3_text,
                          msg_param_1 = taxonomic_name_error,
                          msg_param_2 = taxonomic_kingdom_error,
                          msg_param_3 = taxonomic_family_error)
  )
)
