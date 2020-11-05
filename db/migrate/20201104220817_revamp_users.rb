class RevampUsers < ActiveRecord::Migration[6.0]
  def change
    # Set UUID column to native UUID type
    # https://guides.rubyonrails.org/active_record_postgresql.html#uuid
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    remove_column :users, :uuid, :string
    add_column :users, :uuid, :uuid
    add_index :users, :uuid, unique: true

    remove_reference :users, :account

    remove_column :users, :lg_account_id, :string
    remove_column :users, :lg_agency_id, :string
  end
end
