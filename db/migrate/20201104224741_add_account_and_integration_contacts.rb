class AddAccountAndIntegrationContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :account_contacts do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps

      t.index [:account_id, :user_id], unique: true
    end

    create_table :integration_contacts do |t|
      t.references :integration, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps

      t.index [:integration_id, :user_id], unique: true
    end
  end
end
