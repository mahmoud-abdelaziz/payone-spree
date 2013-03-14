# Container for bank country values.
module Spree::PAYONE
  module Utils
    class BankCountry
      # Bank country values
      DE = 'DE'
      AT = 'AT'
      NL = 'NL'
      CH = 'CH'
      
      # Bank country symbol values
      DE_SYMBOL = :bank_country_de
      AT_SYMBOL = :bank_country_at
      NL_SYMBOL = :bank_country_nl
      CH_SYMBOL = :bank_country_ch
      
      # Validates bank country and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^de$/
          return self::DE
        elsif type =~ /^at$/
          return self::AT
        elsif type =~ /^nl$/
          return self::NL
        elsif type =~ /^ch$/
          return self::CH
        else
          nil
        end
      end
      
      # Validates bank country and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::DE
            return self::DE_SYMBOL
          when self::AT
            return self::AT_SYMBOL
          when self::NL
            return self::NL_SYMBOL
          when self::CH
            return self::CH_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array
      def self.list()
        [self::DE, self::AT, self::NL, self::CH]
      end
    end
  end
end