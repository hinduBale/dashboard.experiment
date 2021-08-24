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
  
  sec_wait_after_upload_click = 15
  sec_wait_after_temporal_click = 10
  
  ## Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  ## Navigate to the Temporal Tab
  helper_navigate_temporal_tab(connectionObj, sec_wait_after_temporal_click)
  
  ## Business Logic
  
  ## Detecting the plot-labels
  plotElement <- connectionObj$findElement(using = "id",
                                           value = helper_temporal_bar_plot_id)
  #print(plotElement$getElementText())
  plotLabelsInitial <- unlist(plotElement$getElementText())
  
  ## Clicking on the Show Plot Field Selector button 
  plotSelectorButton <- connectionObj$findElement(using = "id",
                                                  value = helper_temporal_bar_plot_selector_id)
  plotSelectorButton$clickElement()
  Sys.sleep(10)
  
  ## Clicking on the Select_X button
  selectXButton <- connectionObj$findElement(using = "xpath",
                                             value = helper_temporal_bar_plot_select_X_xpath)
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
                                        value = helper_temporal_bar_plot_ok_id)
  okButton$clickElement()
  Sys.sleep(10)
  
  ## Re-Detecting the plot-labels
  plotElement <- connectionObj$findElement(using = "id",
                                           value = helper_temporal_bar_plot_id)
  #print(plotElement$getElementText())
  plotLabelsNew <- unlist(plotElement$getElementText())
  
  expect_false(all(plotLabelsInitial %in% plotLabelsNew))
  expect_true(x_param %in% unlist(strsplit(plotLabelsNew, "\n")))
  
  if(last_test_param) {
    connectionObj$close()
  }
}, cases(
  custom_fields= list(sample_size_param = "500",
                      search_term_param = "Puma concolor",
                      dataset_param = "gbif",
                      leaflet_param = "decimalLatitude",
                      x_param = "issues",
                      last_test_param = TRUE
  )
))