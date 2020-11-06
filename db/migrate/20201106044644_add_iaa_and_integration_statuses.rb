class AddIAAAndIntegrationStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :account_statuses do |t|
      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps

      t.index :name, unique: :true
      t.index :order, unique: :true
    end

    change_table :accounts do |t|
      t.references :account_status, foreign_key: true
    end

    create_table :iaa_statuses do |t|
      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps

      t.index :name, unique: :true
      t.index :order, unique: :true
    end

    change_table :iaa_gtcs do |t|
      t.references :iaa_status, foreign_key: true
    end

    change_table :iaa_orders do |t|
      t.references :iaa_status, foreign_key: true
    end

    create_table :integration_statuses do |t|
      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps

      t.index :name, unique: :true
      t.index :order, unique: :true
    end

    change_table :integrations do |t|
      t.references :integration_status, foreign_key: true
    end
  end
end
