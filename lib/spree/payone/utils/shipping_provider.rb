# Container for shipping provider values.
module Spree::PAYONE
  module Utils
    class ShippingProvider
      # Shipping provider values
      DHL = 'DHL'
      BARTOLINI = 'BRT'
      
      # Shipping provider symbol values
      DHL_SYMBOL = :shipping_provider_dhl
      BARTOLINI_SYMBOL = :shipping_provider_bartolini
      
      # Validates shipping provider and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^dhl$/
          return self::DHL
        elsif type =~ /^bartolini$/ or type =~ /^brt$/
          return self::BARTOLINI
        else
          nil
        end
      end
      
      # Validates Online bank transfer type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::DHL
            return self::DHL_SYMBOL
          when self::BARTOLINI
            return self::BARTOLINI_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::DHL, self::BARTOLINI]
      end
    end
  end
end