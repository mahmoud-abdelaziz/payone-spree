# Stores Spree PAYONE preferences.
#
# The expectation is that this is created once and stored in
# the spree environment.
module Spree
  AppConfiguration.class_eval do
    
    preference :payone_merchant_id, :string
    preference :payone_payment_portal_id, :string
    preference :payone_payment_portal_key, :string
    preference :payone_sub_account_id, :string
    preference :payone_test_mode, :boolean, :default => true
    
    preference :payone_engine_host, :string, :default => 'localhost:3000'
    
    preference :payone_billing_address_validation_type, :string, :default => 'none'
    preference :payone_billing_address_address_check_address_check_type, :string, :default => 'BA'
    preference :payone_billing_address_consumer_score_address_check_type, :string, :default => 'BA'
    preference :payone_billing_address_consumer_score_consumer_score_type, :string, :default => 'IH'
    
    preference :payone_shipping_address_validation_type, :string, :default => 'none'
    preference :payone_shipping_address_address_check_address_check_type, :string, :default => 'BA'
    preference :payone_shipping_address_consumer_score_address_check_type, :string, :default => 'BA'
    preference :payone_shipping_address_consumer_score_consumer_score_type, :string, :default => 'IH'
    
    preference :payone_address_check_none_person_status_to_consumer_score_score_mapping, :string, :default => 'G'
    preference :payone_address_check_ppb_person_status_to_consumer_score_score_mapping, :string, :default => 'G'
    preference :payone_address_check_phb_person_status_to_consumer_score_score_mapping, :string, :default => 'G'
    preference :payone_address_check_pab_person_status_to_consumer_score_score_mapping, :string, :default => 'R'
    preference :payone_address_check_pki_person_status_to_consumer_score_score_mapping, :string, :default => 'R'
    preference :payone_address_check_pnz_person_status_to_consumer_score_score_mapping, :string, :default => 'R'
    preference :payone_address_check_ppv_person_status_to_consumer_score_score_mapping, :string, :default => 'R'
    preference :payone_address_check_ppf_person_status_to_consumer_score_score_mapping, :string, :default => 'R'
    
    preference :payone_consumer_score_on_yellow_score_allow_total_under, :string, :default => '15.0'
    preference :payone_consumer_score_on_yellow_score_block_total_over, :string, :default => '30.0'
    
    preference :payone_consumer_score_on_yellow_score_gateway_payone_credit_card_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_online_bank_transfer_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_debit_payment_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_e_wallet_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_cash_on_delivery_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_cash_in_advance_enabled, :boolean, :default => true
    preference :payone_consumer_score_on_yellow_score_payment_method_payone_invoice_enabled, :boolean, :default => true
    
    preference :payone_db_logging_enabled, :boolean, :default => true
    preference :payone_file_logging_enabled, :boolean, :default => true
    preference :payone_logger_filepath, :string, :default => 'log/spree_payone.log'
  end
end