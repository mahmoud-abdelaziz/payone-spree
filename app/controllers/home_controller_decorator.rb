module Spree
  HomeController.class_eval do
    before_filter :process_payone_tsok_response, :only => [:index]
    
    protected
      def process_payone_tsok_response
        tsok_check = PayOne::Validators::TsokCheck.new request
        if tsok_check.tsok_request?
          if tsok_check.tsok_request?
            render :text => 'TSOK'
          else
            render :text => ''
          end
        end
      end
  end
end
