# Provides implementation for PAYONE address check.
module Spree::PAYONE
  module Provider
    module Check
      class Address < Spree::PAYONE::Provider::Base
        
        # Proceses check.
        def process(options)
          Spree::PAYONE::Logger.info "Addresscheck process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.addresscheck_request
          
          set_initial_request_parameters(request)
          set_addresscheck_request_parameters(request, options)
          
          response = process_request request, options
        end
        
        # Sets address check parameters.
        def set_addresscheck_request_parameters(request, options)
          request.addresschecktype= options[:addresschecktype]
          request.firstname= options[:firstname]
          request.lastname= options[:lastname]
          request.street= options[:address1]
          request.zip= options[:zip]
          request.city= options[:city]
          request.country= options[:country]
          if request.country == 'US' or request.country == 'CA'
            request.state= options[:state]
          end
        end
      end
    end
  end
end