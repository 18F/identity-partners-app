class AddApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.belongs_to :account
      t.string   :lg_app_id, null: false
      t.string   :name, null: false
      t.text     :description
      t.integer  :ial, null: false
      t.text     :lg_client_ids, array: true, default: []
      t.string   :identity_protocol
      t.date     :certificate_expiration
      t.boolean  :approved, default: false, null: false
      t.boolean  :live, default: false, null: false
      t.date     :live_on
      t.string   :url
      t.integer  :users_in_pop
      t.integer  :users_lifetime
      t.integer  :auths_in_pop
      t.integer  :auths_lifetime
      t.integer  :ial2_users_in_pop
      t.integer  :ial2_users_lifetime
      t.timestamps
    end
  end
end
