class AddConsultingHoursToIAAOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :iaa_orders, :consulting_hours, :integer, null: false, default: 0
  end
end
