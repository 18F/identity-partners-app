class CreateIAAs < ActiveRecord::Migration[6.0]
  def change
    create_table :iaas do |t|
      t.string :number, null: false
      t.date :start_date
      t.date :end_date
      t.date :signed_date
      t.integer :estimated_amount
      t.integer :billed_amount
      t.boolean :active, null: false, default: false
      t.references :account, foreign_key: true, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        change_table :accounts do |t|
          t.remove :iaa_active
          t.remove :iaa_7600a
          t.remove :iaa_7600a_start
          t.remove :iaa_7600a_end
          t.remove :iaa_7600a_amount
          t.remove :iaa_7600a_billed
        end
      end

      dir.down do
        change_table :accounts do |t|
          t.boolean :iaa_active, default: false
          t.string :iaa_7600a
          t.date :iaa_7600a_start
          t.date :iaa_7600a_end
          t.integer :iaa_7600a_amount
          t.integer :iaa_7600a_billed
        end
      end
    end
  end
end
