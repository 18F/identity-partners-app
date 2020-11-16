class AddBillingDataToIAAOrders < ActiveRecord::Migration[6.0]
  def change
    change_table :iaa_orders do |t|
      t.integer :platform_fee, null: false, default: 0
      t.integer :ial2_users, null: false, default: 0
    end

    remove_column :iaa_orders, :billed_amount, :integer
    change_column_null :iaa_orders, :estimated_amount, false
    change_column_default :iaa_orders, :estimated_amount, from: nil, to: 0
  end
end
