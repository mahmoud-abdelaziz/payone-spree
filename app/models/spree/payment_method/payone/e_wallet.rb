module Spree
  class PaymentMethod::PAYONE::EWallet < PaymentMethod::PAYONE::PaymentMethod
    
    # Payment method preferences
    preference :wallet_type, :string, :default => 'PPE'
    
    # Preferences accessors
    attr_accessible :preferred_wallet_type
    
    # Returns true if confirmation needed before processing the payment
    def payment_confirmation_required?
      true
    end
    
    # Provider class responsible for Spree gateway actions implementation
    def provider_class
      ::Spree::PAYONE::Provider::Payment::EWallet
    end
    
    # Payment source class
    def payment_source_class
      Spree::PaymentSource::PAYONE::PayoneEWalletPaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method
    def method_type
      'payone_ewallet'
    end
  end
end
