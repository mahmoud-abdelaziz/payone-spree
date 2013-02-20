module Spree
  class PaymentMethod::PAYONE::DebitPayment < PaymentMethod::PAYONE::PaymentMethod
    
    # Provider class responsible for Spree gateway actions implementation
    def provider_class
      ::Spree::PAYONE::Provider::Payment::DebitPayment
    end
    
    # Payment source class
    def payment_source_class
      Spree::PaymentSource::PAYONE::PayoneDebitPaymentPaymentSource
    end
    
    # Redefines method_type which allows to load correct partial template
    # for payment method
    def method_type
      'payone_debitpayment'
    end
  end
end
