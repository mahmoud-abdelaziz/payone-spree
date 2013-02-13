##
# CreditCard class
# 
# Class provides Spree gateway actions (authorize, capture, purchcase, debit, void).
# 
# PAYONE uses following request codes for specific actions for credit cards:
# - preauthorization
#   Credit card data is verified and stored. The amount is reserved on the customer's card.
# - authorization
#   Card data is verified. Card is charged immediately.
# - capture
#   The card is now charged using the reserved amount. Capturing preauthorised amounts.
# - refund
#   The amount is credited to the customer's card.
# - debit
#   The open balance is credited to or drawn from the customer's card.
# In the Spree nomenclature (adopted from ActiveMerchant) following actions are specified:
# - authorize
#   Authorize a new charge.
# - capture
#   Capture a previously authorized charge.
# - purchase
#   Perform a simultaneous authorization and capture of a new charge.
# - void
#   Void a previously authorized charge. (Not yet fully supported)
# - credit
#   Issue a credit. (Not yet fully supported)
# 
# According to previously stated information we can create bridge between
# PAYONE and Spree functionallity as follow:
#      Spree           PayOne
#      authorize       preauthorization
#      capture         capture
#      purchase        authorization
#      void            refund, N/A
#      credit          N/A
##
module PayOne
  module Provider
    module Payment
      class CreditCard < PayOne::Provider::Payment::Base
      
        # Sets initial data.
        def initialize(options)
          super(options)
        end
        
        # Proceses gateway authorize action.
        def authorize(money, creditcard, gateway_options = {})
          PayOne::Logger.info "Authorize process started"
          
          request = PayOne::Proxy::Request.new
          request.preauthorization_request
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, gateway_options)
          set_credit_card_request_parameters(request, creditcard)
          set_amount_request_parameters(request, money, gateway_options)
          set_order_request_parameters(request, gateway_options)
          set_personal_data_request_parameters(request, gateway_options)
          set_billing_request_parameters(request, gateway_options)
          set_shipping_request_parameters(request, gateway_options)
          
          response = process_request request, gateway_options
          payment_provider_response response
        end
        
        # Proceses gateway purchase action.
        def purchase(money, creditcard, gateway_options = {})
          PayOne::Logger.info "Purchase process started"
          
          request = PayOne::Proxy::Request.new
          request.authorization_request
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, gateway_options)
          set_credit_card_request_parameters(request, creditcard)
          set_amount_request_parameters(request, money, gateway_options)
          set_order_request_parameters(request, gateway_options)
          set_personal_data_request_parameters(request, gateway_options)
          set_billing_request_parameters(request, gateway_options)
          set_shipping_request_parameters(request, gateway_options)
          
          response = process_request request, gateway_options
          payment_provider_response response
        end
        
        # Proceses gateway capture action.
        def capture(money, response_code, gateway_options = {})
          PayOne::Logger.info "Capture process started"
          
          request = PayOne::Proxy::Request.new
          request.capture_request
          
          # For credit card with profile support
          # capture(payment, source, gateway_options)
          if money.kind_of? ::Spree::Payment
            payment = money
            money = (payment.amount * 100).round.to_i
            response_code = payment.response_code
          end
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, gateway_options)
          set_amount_request_parameters(request, money, gateway_options)
          set_payment_process_parameters(request, response_code)
          
          response = process_request request, gateway_options
          payment_provider_response response
        end
        
        # Proceses gateway void action.
        def void(response_code, provider_source, gateway_options = {})
          PayOne::Logger.info "Void process started"
          payment_payment_provider_successful_response
        end
        
        # Proceses gateway credit action.
        def credit(money, provider_source, response_code, gateway_options = {})
          PayOne::Logger.info "Credit process started"
          
          request = PayOne::Proxy::Request.new
          request.debit_request
          set_initial_request_parameters(request)
          set_amount_request_parameters(request, '-' + money.to_s, gateway_options)
          set_payment_process_parameters(request, response_code)
          set_sequence_request_parameters(request, response_code)
          
          response = process_request request, gateway_options
          payment_provider_response response
        end
        
        # Sets credit card parameters.
        def set_credit_card_request_parameters(request, creditcard)
          request.credit_card_clearingtype
          
          if creditcard.gateway_customer_profile_id.nil?
            request.cardexpiredate= credit_card_expire_date(creditcard)
            request.cardtype= credit_card_type(creditcard)
            request.cardpan= creditcard.number
            request.cardcvc2= creditcard.verification_value
            request.cardholder= creditcard.card_holder
          else
            request.pseudocardpan= creditcard.gateway_customer_profile_id
          end
        end
        
        # Returns credit card type.
        # Spree allows to retrieve credit card type with creditcard.cc_type
        # but on this step this value is set to nil. Additionally Spree uses
        # Spree::Creditcard::CardDetector.type?(number) function to detect type.
        # Below type check is based on creditcard preference previously set.
        def credit_card_type(creditcard)
          type = PayOne::Utils::CreditCardType.validate(creditcard.cc_type)
          if type != nil
            return type
          else
            return ''
          end
        end
        
        # Returns credit card expire date in YYMM format.
        def credit_card_expire_date(creditcard)
          creditcard.year[2,2] + ("%.2i" %  creditcard.month)
        end
      end
    end
  end
end