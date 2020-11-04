class CreateIAAOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :iaa_orders do |t|
      t.integer :order_number, null: false
      t.integer :mod_number, null: false, default: 0
      t.date :start_date
      t.date :end_date
      t.date :signed_date
      t.integer :estimated_amount
      t.integer :billed_amount

      t.references :iaa_gtc, foreign_key: true, null: false

      t.timestamps
    end

    add_index :iaa_orders, [:iaa_gtc_id, :order_number], unique: true

    reversible do |dir|
      dir.up do
        change_table :accounts do |t|
          t.remove :iaa_7600b
          t.remove :iaa_7600b_start
          t.remove :iaa_7600b_end
          t.remove :iaa_7600b_amount
          t.remove :iaa_7600b_billed
          t.remove :ial1_users_in_pop
          t.remove :ial2_users_in_pop
        end
      end

      dir.down do
        change_table :accounts do |t|
          t.string :iaa_7600b
          t.date :iaa_7600b_start
          t.date :iaa_7600b_end
          t.integer :iaa_7600b_amount
          t.integer :iaa_7600b_billed
          t.integer :ial1_users_in_pop
          t.integer :ial2_users_in_pop
        end
      end
    end
  end
end
