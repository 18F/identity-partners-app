class CreateIntegrationUsages < ActiveRecord::Migration[6.0]
  def change
    create_table :integration_usages do |t|
      t.references :integration, foreign_key: true
      t.references :iaa_order, foreign_key: true
      t.integer :auths, null: false, default: 0

      t.timestamps

      t.index [:integration_id, :iaa_order_id], unique: true
    end
  end
end
