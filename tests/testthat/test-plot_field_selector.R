## To test this file use:
# testthat::test_file("./tests/testthat/test-plot_field_selector.R")

context("plot_field_selector_functioning")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)


connectionObj$open(silent = TRUE)
patrick::with_parameters_test_that("Plot field selector makes appropriate changes in the plots", {
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
  Sys.sleep(40)
  
  ## Click on the Perform Header Cleaning Button
  darwianizeButton <- connectionObj$findElement(using = "id",
                                                value = "darwinize-darwinizeButton")
  darwianizeButton$clickElement()
  Sys.sleep(8)
  
  ## Temporal Tab
  temporalTab <- connectionObj$findElement(using = "xpath",
                                           value = "/html/body/div[1]/aside/section/ul/li[5]/a/span")
  temporalTab$clickElement()
  Sys.sleep(10)
  
  ## Detecting the plot-labels
  plotElement <- connectionObj$findElement(using = "id",
                                           value = "temporal_tab_ui_1-plotly_bars_ui_1-plot")
  print(plotElement$getElementText())
  plotLabelsInitial <- unlist(plotElement$getElementText())
  
  ## Clicking on the Show Plot Field Selector button 
  plotSelectorButton <- connectionObj$findElement(using = "id",
                                                  value = "temporal_tab_ui_1-plotly_bars_ui_1-plot_field_selector_ui_1-show")
  plotSelectorButton$clickElement()
  Sys.sleep(10)
  
  ## Clicking on the Select_X button
  selectXButton <- connectionObj$findElement(using = "xpath",
                                             value = "/html/body/div[5]/div/div/div/div[1]/div/div[1]/div/div[1]/div/div/div/div[1]/button")
  selectXButton$clickElement()
  Sys.sleep(5)
  
  ## Choosing custom x_param
  selectXOptionID <- sprintf("temporal_tab_ui_1-plotly_bars_ui_1-plot_field_selector_ui_1-cb_%sSelect_X", x_param)
  selectXOptionButton <- connectionObj$findElement(using = "id",
                                                   value = selectXOptionID)
  selectXOptionButton$clickElement()
  Sys.sleep(3)
  
  ## Clicking the Save And Exit Button
  okButton <- connectionObj$findElement(using = "id",
                                        value = "temporal_tab_ui_1-plotly_bars_ui_1-plot_field_selector_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(10)
  
  ## Re-Detecting the plot-labels
  plotElement <- connectionObj$findElement(using = "id",
                                           value = "temporal_tab_ui_1-plotly_bars_ui_1-plot")
  print(plotElement$getElementText())
  plotLabelsNew <- unlist(plotElement$getElementText())
  
  expect_false(all(plotLabelsInitial %in% plotLabelsNew))
  expect_true(x_param %in% unlist(strsplit(plotLabelsNew, "\n")))
}, cases(
  custom_fields= list(sample_size_param = "500",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      leaflet_param = "decimalLatitude",
                      x_param = "issues"
  )
))