# Navigate to Data overview tab
helper_navigate_data_overview_tab <- function(connectionObj) {
  dataOverviewTab <- connectionObj$findElement(using = "xpath",
                                               value = "/html/body/div[1]/aside/section/ul/li[2]/a/span")
  dataOverviewTab$clickElement()
}

# Navigate to missing data tab
helper_navigate_missing_data_tab <- function(connectionObj, sec_wait_after_overview_click) {
  helper_navigate_data_overview_tab(connectionObj)
  Sys.sleep(sec_wait_after_overview_click)
  
  missingDataTab <- connectionObj$findElement(using = "xpath",
                                              value = "/html/body/div[1]/aside/section/ul/li[2]/ul/li[2]/a")
  missingDataTab$clickElement()
}

helper_navigate_spatial_subtab <- function(connectionObj, sec_wait_after_spatial_click) {
  spatialTab <- connectionObj$findElement(using = "xpath",
                                          value = "/html/body/div[1]/aside/section/ul/li[3]/a")
  spatialTab$clickElement()
  Sys.sleep(sec_wait_after_spatial_click)
}

helper_navigate_spatial_tab <- function(connectionObj, sec_wait_after_spatial_click) {
  spatialTab <- connectionObj$findElement(using = "xpath",
                                          value = "/html/body/div[1]/aside/section/ul/li[3]/a/span")
  spatialTab$clickElement()
  Sys.sleep(sec_wait_after_spatial_click)
}