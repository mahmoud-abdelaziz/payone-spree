# Spree payment method which covers PAYONE invoice operations.
#
# Uses ::Spree::PaymentSource::PAYONE::Invoice for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::PAYONE::Invoice < PaymentMethod::PAYONE::PaymentMethod
    
    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::PAYONE::Provider::Payment::Invoice
    end
    
    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::PAYONE::PayoneInvoicePaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_invoice'
    end
  end
end
