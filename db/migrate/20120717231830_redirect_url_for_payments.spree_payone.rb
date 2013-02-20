class RedirectUrlForPayments < ActiveRecord::Migration
  def change
    add_column :spree_payments, :redirect_url, :string
  end
end
