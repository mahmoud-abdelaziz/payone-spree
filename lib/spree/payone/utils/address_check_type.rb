# Container for address check type values.
module Spree::PAYONE
  module Utils
    class AddressCheckType
      # Address check type values
      BASIC = 'BA'
      PERSON = 'PE'
      NO = 'NO'
      
      # Address check type symbol values
      BASIC_SYMBOL = :address_check_type_basic
      PERSON_SYMBOL = :address_check_type_person
      NO_SYMBOL = :address_check_type_no
      
      # Validates address check type and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^basic$/ or type =~ /^ba$/ or type =~ /^b$/
          return self::BASIC
        elsif type =~ /^person$/ or type =~ /^pe$/ or type =~ /^p$/
          return self::PERSON
        elsif type =~ /^none$/ or type =~ /^no$/ or type =~ /^n$/
          return self::NO
        else
          nil
        end
      end
      
      # Validates address check type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::BASIC
            return self::BASIC_SYMBOL
          when self::PERSON
            return self::PERSON_SYMBOL
          when self::NO
            return self::NO_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::BASIC, self::PERSON, self::NO]
      end
    end
  end
end