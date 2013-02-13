class BlockedPaymentMethodTypesForOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :blocked_payment_method_types, :text
  end
end
