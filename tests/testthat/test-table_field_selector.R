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
  dataset_xpath <- eval(parse(text = sprintf("helper_%s_xpath", dataset_param)))
  datasetButton <- connectionObj$findElement(using = "xpath",
                                             value = dataset_xpath)
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
  spatialTab <- connectionObj$findElement(using = "xpath",
                                          value = "/html/body/div[1]/aside/section/ul/li[3]/a")
  spatialTab$clickElement()
  Sys.sleep(2)
  
  tableColNames <- connectionObj$findElement(using = "class",
                                             value = "dataTables_scrollHeadInner")
  initialColNames <- unlist(tableColNames$getElementText())
  print(initialColNames)
 
  fieldSelectorButton <- connectionObj$findElement(using = "id",
                                                   value = "spatial_tab_ui_1-DT_ui_1-show")
  fieldSelectorButton$clickElement()
  Sys.sleep(4)
  
  if(fields_param == "select_core") {
    selectCoreButton <- connectionObj$findElement(using = "id",
                                                  value = "spatial_tab_ui_1-DT_ui_1-select_core")
    selectCoreButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_all"){
    selectAllButton <- connectionObj$findElement(using = "id",
                                                 value = "spatial_tab_ui_1-DT_ui_1-select_all_checkbox")
    selectAllButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_spatial") {
    selectSpatialButton <- connectionObj$findElement(using = "id",
                                                     value = "spatial_tab_ui_1-DT_ui_1-check_select_spatial")
    selectSpatialButton$clickElement()
    Sys.sleep(2)

  } else if(fields_param == "select_temporal") {
    selectTemporalButton <- connectionObj$findElement(using = "id",
                                                     value = "spatial_tab_ui_1-DT_ui_1-check_select_temporal")
    selectTemporalButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_taxonomic") {
    selectTaxonomicButton <- connectionObj$findElement(using = "id",
                                                       value = "spatial_tab_ui_1-DT_ui_1-check_select_taxonomic")
    selectTaxonomicButton$clickElement()
    Sys.sleep(2)
  } else if(fields_param == "select_unlisted") {
    selectUnlistedButton <- connectionObj$findElement(using = "id",
                                                      value = "spatial_tab_ui_1-DT_ui_1-check_select_unlisted")
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
  
  okButton <- connectionObj$findElement(using = "id",
                                        value = "spatial_tab_ui_1-DT_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(5)
  
  tableColNames <- connectionObj$findElement(using = "class",
                                             value = "dataTables_scrollHeadInner")
  newColNames <- unlist(tableColNames$getElementText())
  print(newColNames)
  print(colnames_param)
  
  if(fields_param == "select_custom") {
    expect_true(all(colnames_param %in% unlist(strsplit(newColNames, " "))))
  }
  
  expect_true(!(all(initialColNames %in% newColNames)))
  
  expect_true(TRUE)
  
}, cases(
  custom_fields= list(sample_size_param = "200",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      fields_param = "select_custom",
                      colnames_param = c("decimalLatitude",
                                         "month",
                                         "order",
                                         "datasetKey")),
  select_all = list(sample_size_param = "200",
              search_term_param = "Puma concolor",
              dataset_param = "bison",
              fields_param = "select_all"),  
  select_unlisted = list(sample_size_param = "100",
                          search_term_param = "Puma concolor",
                          dataset_param = "vertnet",
                          fields_param = "select_unlisted"),
  select_temporal = list(sample_size_param = "100",
                         search_term_param = "Puma concolor",
                         dataset_param = "idigbio",
                         fields_param = "select_temporal"),
  ## Show this test-case to Tomer and Rahul C (Put in Issues)
  select_spatial = list(sample_size_param = "100",
                        search_term_param = "Puma concolor",
                        dataset_param = "inaturalist",
                        fields_param = "select_spatial")
))