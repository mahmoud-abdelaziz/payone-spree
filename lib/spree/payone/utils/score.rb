# Container for score values.
module Spree::PAYONE
  module Utils
    class Score
      # Score values
      GREEN  = 'G'
      YELLOW = 'Y'
      RED    = 'R'
      
      # Score symbol values
      GREEN_SYMBOL  = :score_green
      YELLOW_SYMBOL = :score_yellow
      RED_SYMBOL    = :score_red
      
      # Score symbol integer values
      GREEN_INT  = 0
      YELLOW_INT = 1
      RED_INT    = 2
      
      # Validates person status and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^g$/ or type =~ /^green$/
          return self::GREEN
        elsif type =~ /^y$/ or  type =~ /^yellow$/
          return self::YELLOW
        elsif type =~ /^r$/ or type =~ /^red$/
          return self::RED
        else
          nil
        end
      end
      
      # Validates score and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::GREEN
            return self::GREEN_SYMBOL
          when self::YELLOW
            return self::YELLOW_SYMBOL
          when self::RED
            return self::RED_SYMBOL
          else
            return nil
        end
      end
      
      # Returns integer from score value.
      def self.to_i(type)
        case self.validate(type)
          when self::GREEN
            return self::GREEN_INT
          when self::YELLOW
            return self::YELLOW_INT
          when self::RED
            return self::RED_INT
          else
            return nil
        end
      end
      
      # Returns score value from integer.
      def self.to_value(i)
        case i
          when self::GREEN_INT
            return self::GREEN
          when self::YELLOW_INT
            return self::YELLOW
          when self::RED_INT
            return self::RED
          else
            return nil
        end
      end
      
      # Gets lower score from list.
      def self.lower_score(score_a, score_b)
        score_int_a = self.to_i score_a
        score_int_b = self.to_i score_b
        score_int_a ||= self::RED_INT
        score_int_b ||= self::RED_INT
        
        score_int_lower = score_int_a > score_int_b ? score_int_a : score_int_b
        return self.to_value(score_int_lower)
      end
      
      # Returns all values array.
      def self.list()
        [self::GREEN, self::YELLOW, self::RED]
      end
    end
  end
end
