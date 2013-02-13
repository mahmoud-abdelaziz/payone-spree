module Spree
  class PaymentMethod::PAYONE::CashOnDelivery < PaymentMethod::PAYONE::PaymentMethod
    
    # Payment method preferences
    preference :shipping_provider, :string, :default => 'DHL'
    
    # Preferences accessors
    attr_accessible :preferred_shipping_provider
    
    # Provider class responsible for Spree gateway actions implementation
    def provider_class
      ::PayOne::Provider::Payment::CashOnDelivery
    end
    
    # Payment source class
    def payment_source_class
      Spree::PaymentSource::PAYONE::PayoneCashOnDeliveryPaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method
    def method_type
      'payone_cashondelivery'
    end
  end
end
