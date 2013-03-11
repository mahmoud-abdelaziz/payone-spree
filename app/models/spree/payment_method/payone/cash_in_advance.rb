# Spree payment method which covers PAYONE cash in advance operations.
#
# Uses ::Spree::PaymentSource::PAYONE::PayoneCashInAdvancePaymentSource for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::PAYONE::CashInAdvance < PaymentMethod::PAYONE::PaymentMethod
    
    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::PAYONE::Provider::Payment::CashInAdvance
    end
    
    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::PAYONE::PayoneCashInAdvancePaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_cashinadvance'
    end
  end
end
