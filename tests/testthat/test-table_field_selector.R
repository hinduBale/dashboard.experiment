## To test this file use:
# testthat::test_file("./tests/testthat/test-table_field_selector.R")

context("table_field_selector_functioning")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)


connectionObj$open(silent = TRUE)
patrick::with_parameters_test_that("Table field selector makes appropriate changes in the table", {
  
  sec_wait_after_upload_click = 15
  sec_wait_after_spatial_click = 4
  
  # Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  ## Navigate to the spatial tab
  helper_navigate_spatial_tab(connectionObj, sec_wait_after_spatial_click)
  Sys.sleep(2)
  
  ## Business Logic
  tableColNames <- connectionObj$findElement(using = "class",
                                             value = "dataTables_scrollHeadInner")
  initialColNames <- unlist(tableColNames$getElementText())
  # print(initialColNames)
 
  fieldSelectorButton <- connectionObj$findElement(using = "id",
                                                   value = "spatial_tab_ui_1-DT_ui_1-show")
  fieldSelectorButton$clickElement()
  Sys.sleep(4)
  
  if(fields_param == "select_core") {
    selectCoreButton <- connectionObj$findElement(using = "id",
                                                  value = helper_table_select_core_id)
    selectCoreButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_all"){
    selectAllButton <- connectionObj$findElement(using = "id",
                                                 value = helper_table_select_all_id)
    selectAllButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_spatial") {
    selectSpatialButton <- connectionObj$findElement(using = "id",
                                                     value = helper_table_select_spatial_id)
    selectSpatialButton$clickElement()
    Sys.sleep(2)

  } else if(fields_param == "select_temporal") {
    selectTemporalButton <- connectionObj$findElement(using = "id",
                                                     value = helper_table_select_temporal_id)
    selectTemporalButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_taxonomic") {
    selectTaxonomicButton <- connectionObj$findElement(using = "id",
                                                       value = helper_table_select_taxonomic_id)
    selectTaxonomicButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_unlisted") {
    selectUnlistedButton <- connectionObj$findElement(using = "id",
                                                      value = helper_table_select_unlisted_id)
    selectUnlistedButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_custom") {
    buttonIDList <- c()
    for(choice in colnames_param) {
      buttonIDList <- c(buttonIDList, sprintf("spatial_tab_ui_1-DT_ui_1-cb_%s", choice))
    }
    for(buttonID in buttonIDList) {
      selectCustomButton <- connectionObj$findElement(using = "id",
                                                      value = buttonID)
      selectCustomButton$clickElement()
      Sys.sleep(2)
    }
  }
  
  ## Press OK button and wait for changes to take place
  okButton <- connectionObj$findElement(using = "id",
                                        value = "spatial_tab_ui_1-DT_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(5)
  
  tableColNames <- connectionObj$findElement(using = "class",
                                             value = "dataTables_scrollHeadInner")
  newColNames <- unlist(tableColNames$getElementText())
  #print(newColNames)
  #print(colnames_param)
  
  if(fields_param == "select_custom") {
    expect_true(all(colnames_param %in% unlist(strsplit(newColNames, " "))))
  }
  expect_true(!(all(initialColNames %in% newColNames)))
  
  if(last_test_param) {
    connectionObj$close()
  }
}, cases(
  custom_fields= list(sample_size_param = "200",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      fields_param = "select_custom",
                      colnames_param = c("decimalLatitude",
                                         "month",
                                         "order",
                                         "datasetKey"),
                      last_test_param = TRUE),
  select_all = list(sample_size_param = "200",
              search_term_param = "Puma concolor",
              dataset_param = "bison",
              fields_param = "select_all",
              last_test_param = FALSE),  
  select_unlisted = list(sample_size_param = "100",
                          search_term_param = "Puma concolor",
                          dataset_param = "vertnet",
                          fields_param = "select_unlisted",
                         last_test_param = FALSE),
  select_temporal = list(sample_size_param = "100",
                         search_term_param = "Puma concolor",
                         dataset_param = "idigbio",
                         fields_param = "select_temporal",
                         last_test_param = FALSE),
  ## Show this test-case to Tomer and Rahul C (Put in Issues)
  select_spatial = list(sample_size_param = "100",
                        search_term_param = "Puma concolor",
                        dataset_param = "inaturalist",
                        fields_param = "select_spatial",
                        last_test_param = TRUE)
))