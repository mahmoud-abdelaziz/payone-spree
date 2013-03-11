# Provides simple request history functionallity based on PAYONE request history entries.
module Spree::PAYONE
  class RequestHistory
    include Singleton
    
    # Logs request history entry.
    def entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id = nil
      timestamp = Time.now.utc.to_s
      overall_status = overall_status ? 't' : 'f'
      # New connection retrieval moved to PayoneRequestHistory definition
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        sql = 
          "INSERT INTO spree_payone_request_history_entries (`txid`, `request_type`, `status`, `overall_status`, `success_token`, `back_token`, `error_token`, `payment_id`, `created_at`, `updated_at`)
           VALUES ('#{txid.to_s}', '#{request_type.to_s}', '#{status.to_s}', '#{overall_status}', '#{success_token}', '#{back_token}', '#{error_token}', '#{payment_id}', '#{timestamp}', '#{timestamp}')"
        connection.execute sql
      end
    end
    
    # Counts requests with successful overal status with specified txid.
    def count_overall_status_by_txid txid
      ::Spree::PayoneRequestHistoryEntry.where(:txid => txid.to_s, :overall_status => true).count
    end
    
    def self.entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id = nil
      Spree::PAYONE::RequestHistory.instance.entry txid, request_type, status, overall_status, success_token, back_token, error_token, payment_id
    end
    
    def self.count_overall_status_by_txid txid
      Spree::PAYONE::RequestHistory.instance.count_overall_status_by_txid txid
    end
  end
end