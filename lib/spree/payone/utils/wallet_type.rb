# Container for wallet type values.
module Spree::PAYONE
  module Utils
    class WalletType
      # E-wallet type values
      PAYPAL_EXPRESS = 'PPE'
      
      # E-wallet type symbol values
      PAYPAL_EXPRESS_SYMBOL = :wallet_type_paypal_express
      
      # Validates e-wallet type and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^paypal express$/ or type =~ /^paypalexpress$/ or type =~ /^ppe$/
          return self::PAYPAL_EXPRESS
        else
          nil
        end
      end
      
      # Validates online bank transfer type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::PAYPAL_EXPRESS
            return self::PAYPAL_EXPRESS_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::PAYPAL_EXPRESS]
      end
    end
  end
end