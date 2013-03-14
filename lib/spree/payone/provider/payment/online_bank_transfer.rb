# Provides implementation for Spree payment process logic for Spree::PaymentMethod::PAYONE::OnlineBankTransfer
module Spree::PAYONE
  module Provider
    module Payment
      class OnlineBankTransfer < Spree::PAYONE::Provider::Payment::Base
        
        # Sets initial data.
        def initialize(options)
          super(options)
        end
        
        # Proceses payment method authorize action.
        def authorize(money, online_bank_transfer_source, payment_method_options = {})
          Spree::PAYONE::Logger.info "Authorize process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.preauthorization_request
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, payment_method_options)
          set_online_bank_transfer_request_parameters(request, online_bank_transfer_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway purchase action.
        def purchase(money, online_bank_transfer_source, payment_method_options = {})
          Spree::PAYONE::Logger.info "Purchase process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.authorization_request
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, payment_method_options)
          set_online_bank_transfer_request_parameters(request, online_bank_transfer_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway capture action.
        def capture(money, response_code, payment_method_options = {})
          Spree::PAYONE::Logger.info "Capture process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.capture_request
          
          set_initial_request_parameters(request)
          set_status_url_request_parameters(request, payment_method_options)
          set_amount_request_parameters(request, money, payment_method_options)
          set_payment_process_parameters(request, response_code)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway void action.
        def void(response_code, provider_source, gateway_options = {})
          Spree::PAYONE::Logger.info "Void process started"
          payment_payment_provider_successful_response
        end
        
        # Proceses gateway credit action.
        def credit(money, response_code, gateway_options = {})
          Spree::PAYONE::Logger.info "Credit process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.debit_request
          set_initial_request_parameters(request)
          set_amount_request_parameters(request, '-' + money.to_s, gateway_options)
          set_payment_process_parameters(request, response_code)
          set_sequence_request_parameters(request, response_code)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Sets online bank transfer parameters.
        def set_online_bank_transfer_request_parameters(request, online_bank_transfer_source)
          request.online_bank_transfer_clearingtype
          request.bankcountry= online_bank_transfer_source.bank_country
          request.onlinebanktransfertype= online_bank_transfer_type(online_bank_transfer_source)
          
          case request.onlinebanktransfertype
            when Spree::PAYONE::Utils::OnlineBankTransferType::INSTANT_MONEY_TRANSFER
              request.bankaccount= online_bank_transfer_source.bank_account
              request.bankcode= online_bank_transfer_source.bank_code
            when Spree::PAYONE::Utils::OnlineBankTransferType::GIROPAY
              request.bankaccount= online_bank_transfer_source.bank_account
              request.bankcode= online_bank_transfer_source.bank_code
            when Spree::PAYONE::Utils::OnlineBankTransferType::ONLINE_TRANSFER
              request.bankgrouptype= online_bank_transfer_source.bank_group_type
            when Spree::PAYONE::Utils::OnlineBankTransferType::IDEAL
              request.bankgrouptype= online_bank_transfer_source.bank_group_type
          end
        end
        
        # Returns online bank transfer type.
        def online_bank_transfer_type(online_bank_transfer_source)
          type = Spree::PAYONE::Utils::OnlineBankTransferType.validate(online_bank_transfer_source.online_bank_transfer_type)
          if type != nil
            return type
          else
            return ''
          end
        end
      end
    end
  end
end