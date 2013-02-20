module SpreePayone
  class Engine < Rails::Engine
    engine_name 'spree_payone'
    
    config.autoload_paths += %W(#{config.root}/lib)
    
    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
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
    end
    
    config.to_prepare &method(:activate).to_proc
    
    initializer "spree_payone.register.payment_methods", :after => 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods += [
        Spree::Gateway::PAYONE::CreditCard,
        Spree::PaymentMethod::PAYONE::OnlineBankTransfer,
        Spree::PaymentMethod::PAYONE::DebitPayment,
        Spree::PaymentMethod::PAYONE::EWallet,
        Spree::PaymentMethod::PAYONE::CashOnDelivery,
        Spree::PaymentMethod::PAYONE::CashInAdvance,
        Spree::PaymentMethod::PAYONE::Invoice
      ]
    end

  end
end
