# Container for consumer score type values.
module Spree::PAYONE
  module Utils
    class ConsumerScoreType
      # Consumer score type values
      IH = 'IH'
      IA = 'IA'
      IB = 'IB'
      
      # Consumer score type symbol values
      IH_SYMBOL = :consumer_score_type_ih
      IA_SYMBOL = :consumer_score_type_ia
      IB_SYMBOL = :consumer_score_type_ib
      
      # Validates consumer score type and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^ih$/
          return self::IH
        elsif type =~ /^ia$/
          return self::IA
        elsif type =~ /^ib$/
          return self::IB
        else
          nil
        end
      end
      
      # Validates consumer score type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::IH
            return self::IH_SYMBOL
          when self::IA
            return self::IA_SYMBOL
          when self::IB
            return self::IB_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::IH, self::IA, self::IB]
      end
    end
  end
end