Deface::Override.new(
  :virtual_path  => "spree/admin/configurations/index",
  :insert_bottom => "[data-hook='admin_configurations_menu']",
  :partial       => "spree/admin/configurations/index_payone_extension",
  :name          => "index_payone_extension");
  
Deface::Override.new(
  :virtual_path  => "spree/admin/shared/_configuration_menu",
  :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
  :partial       => "spree/admin/shared/configuration_menu_payone_extension",
  :name          => "configuration_menu_payone_extension");
