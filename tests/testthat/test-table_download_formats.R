## To test this file use:
# testthat::test_file("./tests/testthat/test-table_download_formats.R")

context("table_download_options")

library("testthat")
library("RSelenium")
library("patrick")

connectionObj <- RSelenium::remoteDriver(
  remoteServerAddr = helper_remoteServerAddr,
  port = helper_port,
  browserName = helper_browser
)


connectionObj$open(silent = TRUE)
patrick::with_parameters_test_that("Table downloads: ", {
  
  sec_wait_after_upload_click = 15
  sec_wait_after_spatial_click = 4
  
  # Prepare dataset for test
  helper_initialize_tests_default(connectionObj, helper_app_url, sample_size_param, 
                                  search_term_param, dataset_param, sec_wait_after_upload_click)
  Sys.sleep(8)
  
  ## Business Logic
  
  ## Check if file already exists
  filename <- paste0(helper_downloads_path, helper_table_download_file_name, ".",download_extension_param)
  file_exists = file.exists(filename)
  if(file_exists) {
    file.remove(filename)
  }
  
  ## Navigate to the spatial tab
  helper_navigate_spatial_tab(connectionObj, sec_wait_after_spatial_click)
  
  ## Change table structures a bit
  helper_click_selector_button(connectionObj)
  helper_select_all_spatial(connectionObj)
  helper_close_selector_screen(connectionObj)
  
  ## Download the required format
  if()
  download_button_class <- sprintf("btn btn-default buttons-%s buttons-html5", download_extension_param)
  download_button <- connectionObj$findElement(using = "class",
                                               value = download_button_class)
  download_button$clickElement()
  Sys.sleep(10)
  
  ## Check whether table is downloaded with the required extension or not
  file_exists = file.exists(filename)
  
  # Expectations
  expect_true(TRUE)
  expect_true(file_exists)
  
  if(last_test) {
    connectionObj$close()
  }
},
cases(
  gbif = list(sample_size_param = "200",
              search_term_param = "Puma concolor",
              dataset_param = "gbif",
              last_test = FALSE, 
              download_extension_param = "pdf"),
  bison = list(sample_size_param = "200",
               search_term_param = "Puma concolor",
               dataset_param = "bison",
               last_test = TRUE,
               download_extension_param = "csv")
  )
)