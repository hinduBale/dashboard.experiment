helper_app_url <- "http://127.0.0.1:4391"
helper_remoteServerAddr <- "localhost"
helper_port <- 4444
helper_browser <- "chrome"

helper_gbif_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[1]/label/span"
helper_bison_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[5]/label/span"
helper_idigbio_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[2]/label/span"
helper_ecoengine_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[3]/label/span"
helper_vertnet_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[4]/label/span"
helper_inaturalist_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[6]/label/span"
helper_ala_xpath <- "/html/body/div[1]/div/section/div/div[1]/div[1]/div[1]/div/div/div[1]/div[5]/div/div[7]/label/span"

helper_downloads_path <- "C://Users//Rahul//Downloads//"
helper_table_download_file_name <- "dashboard.experimentbddashboard Experiment"
helper_pdf_download_xpath <- "/html/body/div[1]/div/section/div/div[4]/div/div[2]/div[2]/div/div/div[1]/button[4]/span"
helper_csv_download_xapth <- "/html/body/div[1]/div/section/div/div[4]/div/div[2]/div[2]/div/div/div[1]/button[2]/span"
helper_xlsx_download_xpath <- "/html/body/div[1]/div/section/div/div[4]/div/div[2]/div[2]/div/div/div[1]/button[3]/span"
helper_data_overview_xpath <- "/html/body/div[1]/aside/section/ul/li[2]/a/span"
helper_missing_data_xpath <- "/html/body/div[1]/aside/section/ul/li[2]/ul/li[2]/a"
helper_data_summary_xpath <- "/html/body/div[1]/aside/section/ul/li[2]/ul/li[1]/a"
helper_temporal_tab_xpath <- "/html/body/div[1]/aside/section/ul/li[5]/a/span"

helper_spatial_subTab_infoBox1_text <- "of Geo"
helper_spatial_subTab_infoBox2_text = "of Countries"
helper_spatial_subTab_infoBox3_text = "of Localities"

helper_temporal_subTab_infoBox1_text = "of Years"
helper_temporal_subTab_infoBox2_text = "of Months"
helper_temporal_subTab_infoBox3_text = "of Days"

helper_taxonomic_subTab_infoBox1_text = "of Scientific Name"
helper_taxonomic_subTab_infoBox2_text = "of Kingdom"
helper_taxonomic_subTab_infoBox3_text = "of Family"

taxonomic_family_error <- 'No appropriate Column found with family data.'
taxonomic_kingdom_error <- 'No appropriate Column found with kingdom data.'
taxonomic_name_error <- 'No appropriate Column found with scientificName data.'

temporal_day_error <- 'No appropriate Column found with Day data.'
temporal_month_error <- 'No appropriate Column found with Month data.'
temporal_year_error <- 'No appropriate Column found with year data.'

spatial_locality_error <- 'No appropriate Column found with locality data.'
spatial_country_error <- 'No appropriate Column found with country names in it.'
spatial_geo_error <- 'Random String' #Ask Rahul C. about it

helper_spatial_upper_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[1]"
helper_spatial_lower_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[1]"
helper_temporal_upper_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[2]"
helper_temporal_lower_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[2]"
helper_taxonomic_upper_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[2]/div/ul/li[3]"
helper_taxonomic_lower_tab_xpath = "/html/body/div[1]/div/section/div/div[3]/div/div[3]/div/ul/li[3]"

helper_temporal_bar_plot_select_X_xpath <- "/html/body/div[5]/div/div/div/div[1]/div/div[1]/div/div[1]/div/div/div/div[1]/button"
helper_temporal_bar_plot_ok_id <- "temporal_tab_ui_1-plotly_bars_ui_1-plot_field_selector_ui_1-ok"
helper_temporal_bar_plot_selector_id <- "temporal_tab_ui_1-plotly_bars_ui_1-plot_field_selector_ui_1-show"
helper_temporal_bar_plot_id <- "temporal_tab_ui_1-plotly_bars_ui_1-plot"

helper_table_select_core_id <- "spatial_tab_ui_1-DT_ui_1-select_core"
helper_table_select_all_id <- "spatial_tab_ui_1-DT_ui_1-select_all_checkbox"
helper_table_select_spatial_id <- "spatial_tab_ui_1-DT_ui_1-check_select_spatial"
helper_table_select_temporal_id <- "spatial_tab_ui_1-DT_ui_1-check_select_temporal"
helper_table_select_taxonomic_id <- "spatial_tab_ui_1-DT_ui_1-check_select_taxonomic"
helper_table_select_unlisted_id <- "spatial_tab_ui_1-DT_ui_1-check_select_unlisted"

gauge1_error_msg <- 'Random String' #Ask Rahul C. about it
gauge2_error_msg <- 'No appropriate Column with Date data present in Database!'
gauge3_error_msg <- 'No appropriate Column found with occurance remark data/link'
gauge4_error_msg <- 'No appropriate Column found with basisOfRecord data'

map_settings_button_id <- "spatial_tab_ui_1-leaflet_ui_1-show"
map_layer_button_xpath <- "/html/body/div[5]/div/div/div/div[1]/div/div[1]/div/div/div[1]/div/div/div/div[2]/button"