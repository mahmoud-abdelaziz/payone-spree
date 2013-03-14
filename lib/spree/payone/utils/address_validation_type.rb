# Container for address validation type values.
module Spree::PAYONE
  module Utils
    class AddressValidationType
      # Address validation type values
      ADDRESSCHECK = 'addresscheck'
      CONSUMERSCORE = 'consumerscore'
      NONE = 'none'
      
      # Address validation type symbol values
      ADDRESSCHECK_SYMBOL = :address_validation_type_address_check
      CONSUMERSCORE_SYMBOL = :address_validation_type_consumer_score
      NONE_SYMBOL = :address_validation_type_none
      
      # Validates address validation type and returns specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^addresscheck$/ or type =~ /^address check$/ or type =~ /^ac$/ or type =~ /^a$/
          return self::ADDRESSCHECK
        elsif type =~ /^consumerscore$/ or type =~ /^consumer score$/ or type =~ /^cs$/ or type =~ /^c$/
          return self::CONSUMERSCORE
        elsif type =~ /^none$/ or type =~ /^no$/ or type =~ /^n$/
          return self::NONE
        else
          nil
        end
      end
      
      # Validates address validation type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::ADDRESSCHECK
            return self::ADDRESSCHECK_SYMBOL
          when self::CONSUMERSCORE
            return self::CONSUMERSCORE_SYMBOL
          when self::NONE
            return self::NONE_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::ADDRESSCHECK, self::CONSUMERSCORE, self::NONE]
      end
    end
  end
end