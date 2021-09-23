helper_navigate_fun <- function(connectionObj, tabName, sec_delay) {
  if(tabName == "data_overview" || tabName == "missing_data" || tabName == "data_summary" || 
     tabName == "spatial" || tabName == "temporal" || tabName == "taxonomic") {
    dataOverviewTab <- connectionObj$findElement(using = "xpath",
                                                 value = helper_data_overview_xpath)
    dataOverviewTab$clickElement()
    if(tabName == "missing_data") {
      Sys.sleep(sec_delay)
      missingDataTab <- connectionObj$findElement(using = "xpath",
                                                  value = helper_missing_data_xpath)
      missingDataTab$clickElement()
    }
    else if(tabName == "data_summary" || tabName == "spatial" || 
            tabName == "temporal" || tabName == "taxonomic") {
      Sys.sleep(sec_delay)
      dataSummaryTab <- connectionObj$findElement(using = "xpath",
                                                  value = helper_data_summary_xpath)
      dataSummaryTab$clickElement()
      Sys.sleep(5)
      
      if(tabName == "spatial") {
        subtab_id_param = "data_summary_ui_1-patients"
      } else if(tabName == "temporal") {
        subtab_id_param = "data_summary_ui_1-antimicrobials"
      } else if(tabName == "taxonomic") {
        subtab_id_param = "data_summary_ui_1-diagnostics"
      }
      
      subTabButton <- connectionObj$findElement(using = "id",
                                                value = subtab_id_param)
      subTabButton$clickElement()
      Sys.sleep(5)
    }
  }
  else if(tabName == "temporal_tab") {
    temporalTab <- connectionObj$findElement(using = "xpath",
                                             value = helper_temporal_tab_xpath)
    temporalTab$clickElement()
    Sys.sleep(sec_delay)
  }
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


# Navigate to Data overview tab
helper_navigate_data_overview_tab <- function(connectionObj) {
  dataOverviewTab <- connectionObj$findElement(using = "xpath",
                                               value = helper_data_overview_xpath)
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

## Navigate to data summary tab
helper_navigate_data_summary_tab <- function(connectionObj, sec_wait_after_overview_click) {
  helper_navigate_data_overview_tab(connectionObj)
  Sys.sleep(sec_wait_after_overview_click)
  
  dataSummaryTab <- connectionObj$findElement(using = "xpath",
                                              value = "/html/body/div[1]/aside/section/ul/li[2]/ul/li[1]/a")
  dataSummaryTab$clickElement()
  Sys.sleep(5)
}

## Navigate sub-tabs inside the data summary tabs
helper_navigate_subtabs <- function(connectionObj, tabName_param) {
  
  ## Open one of Spatial / Temporal / Taxonomic SubTab
  if(tabName_param == "spatial") {
    subtab_id_param = "data_summary_ui_1-patients"
  } else if(tabName_param == "temporal") {
    subtab_id_param = "data_summary_ui_1-antimicrobials"
  } else if(tabName_param == "taxonomic") {
    subtab_id_param = "data_summary_ui_1-diagnostics"
  }
  
  subTabButton <- connectionObj$findElement(using = "id",
                                            value = subtab_id_param)
  subTabButton$clickElement()
  Sys.sleep(5)
}

## Navigate to the temporal tab
helper_navigate_temporal_tab <- function(connectionObj, sec_wait_after_temporal_click) {
  temporalTab <- connectionObj$findElement(using = "xpath",
                                           value = "/html/body/div[1]/aside/section/ul/li[5]/a/span")
  temporalTab$clickElement()
  Sys.sleep(sec_wait_after_temporal_click)
}