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
  Sys.sleep(10)
  
  legendBox <- connectionObj$findElement(using = "css selector",
                                         value = ".leaflet-control-layers")
  print(legendBox$getElementText())
  initialLegendText <- unlist(legendBox$getElementText())
  
  ## Click on the Map Settings button
  mapSettingsButton <- connectionObj$findElement(using = "id",
                                                 value = "spatial_tab_ui_1-leaflet_ui_1-show")
  mapSettingsButton$clickElement()
  Sys.sleep(4)
  
  ## Click on the Map Layer Button
  mapLayerButton <- connectionObj$findElement(using = "xpath",
                                              value = "/html/body/div[5]/div/div/div/div[1]/div/div[1]/div/div/div[1]/div/div/div/div[2]/button")
  mapLayerButton$clickElement()
  Sys.sleep(4)

  leafletOptionID <- sprintf("spatial_tab_ui_1-leaflet_ui_1-cb_%s", leaflet_param)
  leafletOptionButton <- connectionObj$findElement(using = "id",
                                                   value = leafletOptionID)
  leafletOptionButton$clickElement()
  Sys.sleep(2)

  okButton <- connectionObj$findElement(using = "id",
                                        value = "spatial_tab_ui_1-leaflet_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(20)

  legendText <- connectionObj$findElement(using = "xpath",
                                          value = "/html/body/div[1]/div/section/div/div[4]/div/div[1]/div[2]/div/div[2]/div[2]/div[2]/div")
  newLegendText <- unlist(legendText$getElementText())
  print(newLegendText)

  expect_false(all(initialLegendText %in% newLegendText))
#  expect_true(TRUE)
}, cases(
  custom_fields= list(sample_size_param = "100",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      leaflet_param = "decimalLatitude"
                      )
))