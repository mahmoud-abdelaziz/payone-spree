##
# PayoneLog class
# 
# Class provides PAYONE logging functionality.
##
module Spree
  class PayoneLog < ActiveRecord::Base
    # We must run logger in other connection because of possible transaction
    # while we don't want our logs to be rollbacked
    # See: state_machine documentation
    establish_connection Rails.env.to_sym
    
    attr_accessible :level, :message
  end
end
