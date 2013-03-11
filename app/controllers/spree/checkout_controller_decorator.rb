module Spree
  CheckoutController.class_eval do
    
    # Updates the order and advances to the next state (when possible).
    # Contains redefined Order steps to handle PAYONE thirdparty redirection.
    def update
      if @order.update_attributes(object_params)
        fire_event('spree.checkout.update')
        
        if @order.next
          if @order.redirect_required? && @order.state == "complete"
            @order.payments.each do |payment|
              if !payment.redirect_url.to_s.empty?
                attrs = payment.attributes
                payment.reload
                attrs.each do |key, value|
                  payment.update_attribute key, value
                end
                
                # Change state to :payment_redirect
                @order.next
                redirect_to payment.redirect_url.to_s and return
              end
            end
          end
          
          state_callback(:after)
        else
          flash[:error] = t(:payment_processing_failed)
          respond_with(@order, :location => checkout_state_path(@order.state))
          return
        end
        
        if @order.state == "complete" || @order.completed?
          flash.notice = t(:order_processed_successfully)
          flash[:commerce_tracking] = "nothing special"
          respond_with(@order, :location => completion_route)
        else
          respond_with(@order, :location => checkout_state_path(@order.state))
        end
      else
        respond_with(@order) { |format| format.html { render :edit } }
      end
    end
    
    def payone_success
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]
      
      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :success_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first
          
          if payment.response_code == request_history_entry.txid
            if request_history_entry.request_type == "authorization"
              payment.complete!
            else
              payment.pend!
            end
            request_history_entry.overall_status = true
            request_history_entry.save
            
            # Process complete order step
            unless @order.state == "complete" || @order.completed?
              # We must process changes manually
              @order.state= :complete
              @order.finalize!
              @order.update!
              state_callback(:after)
            end
            
            flash.notice = t(:order_processed_successfully)
            redirect_to completion_route and return
          end
        end
      end
      
      # Redirect to error if not handled already
      flash[:error] = t(:payment_processing_failed)
      respond_with(@order, :location => checkout_state_path(@order.state))
      return
    end
    
    def payone_error
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]
      
      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :error_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first
          
          if payment.response_code == request_history_entry.txid
            payment.failure
          end
        end
      end
      
      @order.state = 'payment'
      @order.save
      
      flash[:error] = t(:payment_processing_failed)
      respond_with(@order) { |format| format.html { render :edit } }
    end
    
    def payone_back
      token = params[:token]
      action_token = params[:action_token]
      payment_id = params[:payment_id]
      
      # Try to find payment with specified token
      if @order.token == token
        payments =
          @order.payments.where(:id => payment_id)
        request_history_entries =
          ::Spree::PayoneRequestHistoryEntry.where(
            :payment_id => payment_id, :back_token => action_token)
        if payments.present? && request_history_entries.present?
          payment = payments.first
          request_history_entry = request_history_entries.first
          
          if payment.response_code == request_history_entry.txid
            payment.failure
          end
        end
      end
      
      @order.state = 'payment'
      @order.save
      
      flash[:error] = t(:payment_processing_canceled)
      respond_with(@order) { |format| format.html { render :edit } }
    end
  end
end
