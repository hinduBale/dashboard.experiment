helper_click_selector_button <- function(connectionObj) {
  fieldSelectorButton <- connectionObj$findElement(using = "id",
                                                   value = "spatial_tab_ui_1-DT_ui_1-show")
  fieldSelectorButton$clickElement()
  Sys.sleep(4)
}

helper_select_all_spatial <- function(connectionObj) {
  selectSpatialButton <- connectionObj$findElement(using = "id",
                                                   value = "spatial_tab_ui_1-DT_ui_1-check_select_spatial")
  selectSpatialButton$clickElement()
  Sys.sleep(2)
}

helper_close_selector_screen <- function(connectionObj) {
  okButton <- connectionObj$findElement(using = "id",
                                        value = "spatial_tab_ui_1-DT_ui_1-ok")
  okButton$clickElement()
  Sys.sleep(10)
}