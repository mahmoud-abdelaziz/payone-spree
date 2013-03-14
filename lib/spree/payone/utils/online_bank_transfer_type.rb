# Container for online bank transfer type values.
module Spree::PAYONE
  module Utils
    class OnlineBankTransferType
      # Online bank transfer type values
      INSTANT_MONEY_TRANSFER = 'PNT'
      GIROPAY = 'GPY'
      ONLINE_TRANSFER = 'EPS'
      POSTFINANCE_E_FINANCE = 'PFF'
      POSTFINANCE_CARD = 'PFC'
      IDEAL = 'IDL'
      
      # Online bank transfer type symbol values
      INSTANT_MONEY_TRANSFER_SYMBOL = :online_bank_transfer_type_instant_money_transfer
      GIROPAY_SYMBOL = :online_bank_transfer_type_giropay
      ONLINE_TRANSFER_SYMBOL = :online_bank_transfer_type_online_transfer
      POSTFINANCE_E_FINANCE_SYMBOL = :online_bank_transfer_type_postfinance_e_finance
      POSTFINANCE_CARD_SYMBOL = :online_bank_transfer_type_postfinance_card
      IDEAL_SYMBOL = :online_bank_transfer_type_ideal
      
      # Validates Online bank transfer type and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^instant money transfer$/ or type =~ /^instantmoneytransfer$/ or type =~ /^pnt$/
          return self::INSTANT_MONEY_TRANSFER
        elsif type =~ /^giropay$/ or type =~ /^master card$/ or type =~ /^gpy$/
          return self::GIROPAY
        elsif type =~ /^online transfer$/ or type =~ /^onlinetransfer$/ or type =~ /^eps$/
          return self::ONLINE_TRANSFER
        elsif type =~ /^postfinanceefinance$/ or type =~ /^postfinancee-finance$/ or type =~ /^postfinance e finance$/ or type =~ /^postfinance e-finance$/ or type =~ /^pff$/
          return self::POSTFINANCE_E_FINANCE
        elsif type =~ /^postfinancecard$/ or type =~ /^postfinance card$/ or type =~ /^pfc$/
          return self::POSTFINANCE_CARD
        elsif type =~ /^ideal$/ or type =~ /^idl$/
          return self::IDEAL
        else
          nil
        end
      end
      
      # Validates Online bank transfer type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::INSTANT_MONEY_TRANSFER
            return self::INSTANT_MONEY_TRANSFER_SYMBOL
          when self::GIROPAY
            return self::GIROPAY_SYMBOL
          when self::ONLINE_TRANSFER
            return self::ONLINE_TRANSFER_SYMBOL
          when self::POSTFINANCE_E_FINANCE
            return self::POSTFINANCE_E_FINANCE_SYMBOL
          when self::POSTFINANCE_CARD
            return self::POSTFINANCE_CARD_SYMBOL
          when self::IDEAL
            return self::IDEAL_SYMBOL
          else
            return nil
        end
      end
      
      # Validates Online bank transfer type and returns symbol.
      def self.validate_online_bank_transfer_type_country(type, country)
        country = country.to_s.upcase
        case type
          when self::INSTANT_MONEY_TRANSFER_SYMBOL
            return country == 'DE' || country == 'AT' || country == 'CH'
          when self::GIROPAY_SYMBOL
            return country == 'DE'
          when self::ONLINE_TRANSFER_SYMBOL
            return country == 'AT'
          when self::POSTFINANCE_E_FINANCE_SYMBOL
            return country == 'CH'
          when self::POSTFINANCE_CARD_SYMBOL
            return country == 'CH'
          when self::IDEAL_SYMBOL
            return country == 'NL'
          else
            return false
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::INSTANT_MONEY_TRANSFER, self::GIROPAY, self::ONLINE_TRANSFER,
         self::POSTFINANCE_E_FINANCE, self::POSTFINANCE_CARD, self::IDEAL]
      end
    end
  end
end