## To test this file use:
# testthat::test_file("./tests/testthat/test-map_field_selector.R")

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
patrick::with_parameters_test_that("Map field selector makes appropriate changes in the leaflet maps", {
  sec_wait_after_upload_click = 15
  sec_wait_after_spatial_click = 10
  
  ## Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  ## Navigate to the Spatial Tab
  helper_navigate_spatial_tab(connectionObj, sec_wait_after_spatial_click)
  
  
  ## Business Logic
  legendBox <- connectionObj$findElement(using = "css selector",
                                         value = ".leaflet-control-layers")
  initialLegendText <- unlist(legendBox$getElementText())
  
  ## Click on the Map Settings button
  mapSettingsButton <- connectionObj$findElement(using = "id",
                                                 value = map_settings_button_id)
  mapSettingsButton$clickElement()
  Sys.sleep(4)
  
  ## Click on the Map Layer Button
  mapLayerButton <- connectionObj$findElement(using = "xpath",
                                              value = map_layer_button_xpath)
  mapLayerButton$clickElement()
  Sys.sleep(4)
  
  ## Selecting the specified option on the map leaflet
  leafletOptionID <- sprintf("spatial_tab_ui_1-leaflet_ui_1-cb_%s", leaflet_param)
  leafletOptionButton <- connectionObj$findElement(using = "id",
                                                   value = leafletOptionID)
  leafletOptionButton$clickElement()
  Sys.sleep(2)
  
  ## Press on the OK button and wait for changes to take place
  okButton <- connectionObj$findElement(using = "id",
                                        value = "spatial_tab_ui_1-leaflet_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(20)
  
  ## Read new legend text
  legendText <- connectionObj$findElement(using = "xpath",
                                          value = "/html/body/div[1]/div/section/div/div[4]/div/div[1]/div[2]/div/div[2]/div[2]/div[2]/div")
  newLegendText <- unlist(legendText$getElementText())
  
  expect_false(all(initialLegendText %in% newLegendText))
}, cases(
  custom_fields= list(sample_size_param = "100",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      leaflet_param = "eventDate"
                      )
))