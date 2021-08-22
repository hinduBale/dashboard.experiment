helper_navigate_to_shiny_app <- function(connectionObj, app_url) {
  connectionObj$navigate(app_url)
}

helper_reduce_sample_size <- function(connectionObj, sample_size_param) {
  sampleSize <- connectionObj$findElement(using = "id",
                                          value = "bdFileInput-recordSize")
  sampleSize$clearElement()
  sampleSize$sendKeysToElement(list(sample_size_param))
}

helper_change_search_term <- function(connectionObj, search_term_param) {
  searchTerm <- connectionObj$findElement(using = "id",
                                          value = "bdFileInput-scientificName")
  searchTerm$clearElement()
  searchTerm$sendKeysToElement(list(search_term_param))  
}

helper_select_dataset_and_darwianize <- function(connectionObj, dataset_param, sec_wait_after_upload_click) {
  dataset_xpath <- eval(parse(text = sprintf("helper_%s_xpath", dataset_param)))
  datasetButton <- connectionObj$findElement(using = "xpath",
                                             value = dataset_xpath)
  datasetButton$clickElement()
  Sys.sleep(2)
  uploadButton <- connectionObj$findElement(using = "id",
                                            value = "bdFileInput-queryDatabase")
  uploadButton$clickElement()
  Sys.sleep(sec_wait_after_upload_click)
  darwianizeButton <- connectionObj$findElement(using = "id",
                                                value = "darwinize-darwinizeButton")
  darwianizeButton$clickElement()
}

helper_initialize_tests_default <- function(connectionObj, helper_app_url, sample_size_param, 
                                            search_term_param, dataset_param, sec_wait_after_upload_click) {
  helper_navigate_to_shiny_app(connectionObj, helper_app_url)
  Sys.sleep(8)
  
  ## Reduce sample size
  helper_reduce_sample_size(connectionObj, sample_size_param)
  Sys.sleep(2)
  
  ## Change search term
  helper_change_search_term(connectionObj, search_term_param)
  
  ## Select online dataset
  helper_select_dataset_and_darwianize(connectionObj, dataset_param, sec_wait_after_upload_click)
}