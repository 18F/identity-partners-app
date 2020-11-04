class CreateIntegrations < ActiveRecord::Migration[6.0]
  def change
    create_table :integrations do |t|
      t.string :issuer, null: false
      t.string :name, null: false
      t.text :description
      t.string :dashboard_url
      t.boolean :ial2, null: false, default: false
      t.string :protocol, null: false, default: 'oidc'
      t.string :url
      t.date :go_live
      t.date :prod_deploy

      t.references :account, foreign_key: true

      t.timestamps

      t.index :issuer, unique: true
    end

    reversible do |dir|
      dir.up do
        drop_table :apps
      end

      dir.down do
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
  end
end
