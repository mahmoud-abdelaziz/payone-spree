module Spree
  CheckoutHelper.class_eval do
    alias_method :original_checkout_states, :checkout_states
    
    def checkout_states
      # Add confirmation step to payments with set confirmation required - extend Spree native logic
      if @order.payment_method and @order.payment_method.respond_to?(:payment_confirmation_required?) and @order.payment_method.payment_confirmation_required?
        %w(address delivery payment confirm complete)
      else
        original_checkout_states
      end
    end
  end
end
