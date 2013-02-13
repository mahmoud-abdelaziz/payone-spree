##
# PayoneRequestHistoryEntry class
# 
# Class provides PAYONE request history functionality.
##
module Spree
  class PayoneRequestHistoryEntry < ActiveRecord::Base
    # We must run logger in other connection because of possible transaction
    # while we don't want our logs to be rollbacked
    # See: state_machine documentation
    establish_connection Rails.env.to_sym
    
    attr_accessible :txid, :request_type, :status, :overall_status
  end
end
