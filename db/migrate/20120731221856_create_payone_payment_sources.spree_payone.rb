class CreatePayonePaymentSources < ActiveRecord::Migration
  def change
    create_table :spree_payone_online_bank_transfer_payment_sources do |t|
      t.string :first_name, :last_name, :online_bank_transfer_type, :bank_country,
               :bank_account, :bank_code, :bank_group_type
      
      t.timestamps
    end
    
    create_table :spree_payone_debit_payment_payment_sources do |t|
      t.string :first_name, :last_name, :bank_country, :bank_account,
               :bank_code, :bank_account_holder
      
      t.timestamps
    end
    
    create_table :spree_payone_e_wallet_payment_sources do |t|
      t.string :first_name, :last_name, :wallet_type
      
      t.timestamps
    end
    
    create_table :spree_payone_cash_on_delivery_payment_sources do |t|
      t.string :first_name, :last_name, :shipping_provider
      
      t.timestamps
    end
    
    create_table :spree_payone_cash_in_advance_payment_sources do |t|
      t.string :first_name, :last_name
      
      t.timestamps
    end
    
    create_table :spree_payone_invoice_payment_sources do |t|
      t.string :first_name, :last_name
      
      t.timestamps
    end
  end
end
