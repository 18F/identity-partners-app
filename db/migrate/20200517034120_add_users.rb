class AddUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :account
      t.string  :uuid
      t.string  :email, null: false
      t.string  :first_name
      t.string  :last_name
      t.string  :title
      t.string  :phone
      t.string  :lg_account_id
      t.string  :lg_agency_id
      t.boolean :admin, null: false, default: false

      # Devise
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    add_index :users, :uuid, unique: true
    add_index :users, :email, unique: true
  end
end
