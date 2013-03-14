# Container for person status values.
module Spree::PAYONE
  module Utils
    class PersonStatus
      # Person status values
      NONE = 'NONE'
      PPB  = 'PPB'
      PHB  = 'PHB'
      PAB  = 'PAB'
      PKI  = 'PKI'
      PNZ  = 'PNZ'
      PPV  = 'PPV'
      PPF  = 'PPF'
      
      # Person status symbol values
      NONE_SYMBOL = :person_status_none
      PPB_SYMBOL  = :person_status_ppb
      PHB_SYMBOL  = :person_status_phb
      PAB_SYMBOL  = :person_status_pab
      PKI_SYMBOL  = :person_status_pki
      PNZ_SYMBOL  = :person_status_pnz
      PPV_SYMBOL  = :person_status_ppv
      PPF_SYMBOL  = :person_status_ppf
      
      # Validates person status and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^none$/
          return self::NONE
        elsif type =~ /^ppb$/
          return self::PPB
        elsif type =~ /^phb$/
          return self::PHB
        elsif type =~ /^pab$/
          return self::PAB
        elsif type =~ /^pki$/
          return self::PKI
        elsif type =~ /^pnz$/
          return self::PNZ
        elsif type =~ /^ppv$/
          return self::PPV
        elsif type =~ /^ppf$/
          return self::PPF
        else
          nil
        end
      end
      
      # Validates person status and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::NONE
            return self::NONE_SYMBOL
          when self::PPB
            return self::PPB_SYMBOL
          when self::PHB
            return self::PHB_SYMBOL
          when self::PAB
            return self::PAB_SYMBOL
          when self::PKI
            return self::PKI_SYMBOL
          when self::PNZ
            return self::PNZ_SYMBOL
          when self::PPV
            return self::PPV_SYMBOL
          when self::PPF
            return self::PPF_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::NONE, self::PPB, self::PHB, self::PAB, self::PKI, self::PNZ, self::PPV, self::PPF]
      end
    end
  end
end