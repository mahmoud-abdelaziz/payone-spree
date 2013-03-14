# Provides implementation for PAYONE TSOK validation.
module Spree::PAYONE
  module Validators
    class TsokCheck
      def initialize request
        @request = request
      end
      
      def tsok_request?
        if @request.post? and valid_ip?
          true
        end
      end
      
      def valid_tsok_request?
        true
      end
      
      def valid_ip?
        ip = @request.ip.to_s
        if ip =~ /^213.178.72.196$/ or
           ip =~ /^213.178.72.197$/ or
           ip =~ /^217.70.200.[0-9]$/ or
           ip =~ /^217.70.200.[1-9][0-9]$/ or
           ip =~ /^217.70.200.[1-2][0-4][0-9]$/ or
           ip =~ /^217.70.200.[1-2]5[0-5]$/
          true
        else
          false
        end
      end
    end
  end
end