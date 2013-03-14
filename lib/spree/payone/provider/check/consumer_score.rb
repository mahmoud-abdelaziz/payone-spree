# Provides implementation for PAYONE consumerscore check.
module Spree::PAYONE
  module Provider
    module Check
      class ConsumerScore < Spree::PAYONE::Provider::Base
        
        # Proceses check.
        def process(options)
          Spree::PAYONE::Logger.info "Consumerscore process started"
          
          request = Spree::PAYONE::Proxy::Request.new
          request.consumerscore_request
          
          set_initial_request_parameters(request)
          set_consumerscore_request_parameters(request, options)
          
          response = process_request request, options
        end
        
        # Sets consumer score parameters.
        def set_consumerscore_request_parameters(request, options)
          request.addresschecktype= options[:addresschecktype]
          request.consumerscoretype= options[:consumerscoretype]
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