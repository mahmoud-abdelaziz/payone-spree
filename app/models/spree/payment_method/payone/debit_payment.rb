# Spree payment method which covers PAYONE debit payment operations.
#
# Uses ::Spree::PaymentSource::PAYONE::DebitPayment for standard
# Spree payment method action implementations.
module Spree
  class PaymentMethod::PAYONE::DebitPayment < PaymentMethod::PAYONE::PaymentMethod
    
    # Returns provider class responsible for Spree payment method action implementations.
    def provider_class
      ::Spree::PAYONE::Provider::Payment::DebitPayment
    end
    
    # Returns payment source class.
    def payment_source_class
      ::Spree::PaymentSource::PAYONE::PayoneDebitPaymentPaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method.
    def method_type
      'payone_debitpayment'
    end
  end
end
