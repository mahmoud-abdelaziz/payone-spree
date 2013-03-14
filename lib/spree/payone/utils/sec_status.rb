# Container for sec status values.
module Spree::PAYONE
  module Utils
    class SecStatus
      # Second status values
      S10 = '10'
      S20 = '20'
      S30 = '30'
      
      # Second status symbol values
      S10_SYMBOL = :sec_status_s10
      S20_SYMBOL = :sec_status_s20
      S30_SYMBOL = :sec_status_s30
      
      # Validates second status and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^10$/
          return self::S10
        elsif type =~ /^20$/
          return self::S20
        elsif type =~ /^30$/
          return self::S30
        else
          nil
        end
      end
      
      # Validates second status and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::S10
            return self::S10_SYMBOL
          when self::S20
            return self::S20_SYMBOL
          when self::S30
            return self::S30_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::S10, self::S20, self::S30]
      end
    end
  end
end