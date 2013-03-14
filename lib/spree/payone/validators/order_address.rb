# Provides implementation for PAYONE orderaddress validation.
module Spree::PAYONE
  module Validators
    class OrderAddress
      
      # Validates order addresses.
      def self.validate order
        # Cleanup previuosly blocked payment methods
        order.blocked_payment_method_types= ''
        
        valid = self.process_address_validation order, 'billing_address'
        valid = self.process_address_validation order, 'shipping_address'
        
        # Valid even if all paymet methods has been deleted
        true
      end
      
      # Processes validation for specified order address field (billing or shipping).
      def self.process_address_validation order, address_field
        return false unless order.respond_to?(address_field)
        order_address = order.send(address_field)
        
        valid = true
        options = order_address.try(:active_merchant_hash)
        options.merge!({
          :firstname => order_address.firstname,
          :lastname => order_address.lastname })
        if Spree::Config["payone_#{address_field}_validation_type".to_sym] == Spree::PAYONE::Utils::AddressValidationType::ADDRESSCHECK
          options.merge!({
            :addresschecktype => Spree::Config["payone_#{address_field}_address_check_address_check_type".to_sym] })
          check = Spree::PAYONE::Provider::Check::Address.new({ :use_global_account_settings => true})
          response = check.process options
          valid = self.handle_response response, order, address_field
        elsif Spree::Config["payone_#{address_field}_validation_type".to_sym] == Spree::PAYONE::Utils::AddressValidationType::CONSUMERSCORE
          options.merge!({
            :addresschecktype => Spree::Config["payone_#{address_field}_consumer_score_address_check_type".to_sym],
            :consumerscoretype => Spree::Config["payone_#{address_field}_consumer_score_consumer_score_type".to_sym] })
          check = Spree::PAYONE::Provider::Check::ConsumerScore.new({ :use_global_account_settings => true})
          response = check.process options
          valid = self.handle_response response, order, address_field
        end
        valid
      end
      
      def self.handle_response response, order, address_field
        return false unless order.respond_to?(address_field)
        order_address = order.send(address_field)
        
        valid = response.valid_status?
        if valid
          # Apply corrected data
          if response.secstatus == Spree::PAYONE::Utils::SecStatus::S20
            order_address.firstname = response.firstname unless response.firstname == nil
            order_address.lastname = response.lastname unless response.lastname == nil
            order_address.address1 = response.street unless response.street == nil
            order_address.zipcode = response.zip unless response.zip == nil
            order_address.city = response.city unless response.city == nil
          end
          
          # Map Addresscheck person score to Consumerscore score
          unless response.personstatus == nil
            score = nil
            map = self.address_check_person_status_to_consumer_score_score_mapping
            if map.include? response.personstatus
              score = Spree::PAYONE::Utils::Score.validate(map[response.personstatus])
            end
            
            # Rewrite score if mapped more restricted
            response.score = Spree::PAYONE::Utils::Score.lower_score(response.score, score || Spree::PAYONE::Utils::Score::RED)
            # Add error message even if will not fail
            order.errors.add(:base, Spree::PAYONE::Utils::PersonStatus.validate_symbol(response.personstatus))
          end
        else
          order.errors.add(:base, response.customermessage)
        end
        
        case response.score
          when Spree::PAYONE::Utils::Score::RED
            valid = self.handle_consumer_score_response_red(order)
          when Spree::PAYONE::Utils::Score::YELLOW
            valid = self.handle_consumer_score_response_yellow(order)
          when Spree::PAYONE::Utils::Score::GREEN
            valid = self.handle_consumer_score_response_green(order)
          else
            valid = self.handle_consumer_score_response_green(order)
        end
        
        valid
      end
      
      # Handles consumerscore RED response.
      def self.handle_consumer_score_response_red order
        blocked = order.blocked_payment_method_types_array
        
        # Block all blocked methods
        blocked << Spree::Gateway::PAYONE::CreditCard.to_s
        blocked << Spree::PaymentMethod::PAYONE::OnlineBankTransfer.to_s
        blocked << Spree::PaymentMethod::PAYONE::DebitPayment.to_s
        blocked << Spree::PaymentMethod::PAYONE::EWallet.to_s
        blocked << Spree::PaymentMethod::PAYONE::CashOnDelivery.to_s
        blocked << Spree::PaymentMethod::PAYONE::CashInAdvance.to_s
        blocked << Spree::PaymentMethod::PAYONE::Invoice.to_s
        
        blocked.uniq!
        order.blocked_payment_method_types = blocked.join(',')
        false
      end
      
      # Handles consumerscore YELLOW response.
      def self.handle_consumer_score_response_yellow order
        allow_under = Spree::Config[:payone_consumer_score_on_yellow_score_allow_total_under].to_s.to_f
        block_over = Spree::Config[:payone_consumer_score_on_yellow_score_block_total_over].to_s.to_f
        
        if order.total.to_f < allow_under
          return self.handle_consumer_score_response_green order
        elsif order.total.to_f > block_over
          return self.handle_consumer_score_response_red order
        else
          blocked = order.blocked_payment_method_types_array
          # Check which payment methods should be blocked
          # Add blocked methods
          blocked << Spree::Gateway::PAYONE::CreditCard.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_gateway_payone_credit_card_enabled]
          blocked << Spree::PaymentMethod::PAYONE::OnlineBankTransfer.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_online_bank_transfer_enabled]
          blocked << Spree::PaymentMethod::PAYONE::DebitPayment.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_debit_payment_enabled]
          blocked << Spree::PaymentMethod::PAYONE::EWallet.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_e_wallet_enabled]
          blocked << Spree::PaymentMethod::PAYONE::CashOnDelivery.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_cash_on_delivery_enabled]
          blocked << Spree::PaymentMethod::PAYONE::CashInAdvance.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_cash_in_advance_enabled]
          blocked << Spree::PaymentMethod::PAYONE::Invoice.to_s \
            if !Spree::Config[:payone_consumer_score_on_yellow_score_payment_method_payone_invoice_enabled]
          
          blocked.uniq!
          order.blocked_payment_method_types = blocked.join(',')
          return true
        end
      end
      
      # Handles consumerscore GREEN response.
      def self.handle_consumer_score_response_green order
        # Do nothing
        true
      end
      
      # Returns mapping between addresscheck person status and consumerscore core.
      def self.address_check_person_status_to_consumer_score_score_mapping
        map = {
          Spree::PAYONE::Utils::PersonStatus::NONE =>
            Spree::Config[:payone_address_check_none_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PPB =>
            Spree::Config[:payone_address_check_ppb_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PHB =>
            Spree::Config[:payone_address_check_phb_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PAB =>
            Spree::Config[:payone_address_check_pab_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PKI =>
            Spree::Config[:payone_address_check_pki_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PNZ =>
            Spree::Config[:payone_address_check_pnz_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PPV =>
            Spree::Config[:payone_address_check_ppv_person_status_to_consumer_score_score_mapping],
          Spree::PAYONE::Utils::PersonStatus::PPF =>
            Spree::Config[:payone_address_check_ppf_person_status_to_consumer_score_score_mapping]
        }
      end
    end
  end
end