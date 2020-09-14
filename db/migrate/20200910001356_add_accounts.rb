class AddAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string   :lg_account_id, null: false
      t.string   :name, null: false
      t.text     :description
      t.integer  :lg_agency_id
      t.boolean  :iaa_active, default: false
      t.string   :iaa_7600a
      t.date     :iaa_7600a_start
      t.date     :iaa_7600a_end
      t.integer  :iaa_7600a_amount
      t.integer  :iaa_7600a_billed
      t.string   :iaa_7600b
      t.date     :iaa_7600b_start
      t.date     :iaa_7600b_end
      t.integer  :iaa_7600b_amount
      t.integer  :iaa_7600b_billed
      t.integer  :pricing
      t.integer  :ial1_users_in_pop
      t.integer  :ial2_users_in_pop
      t.date     :became_partner
      t.timestamps
    end
  end
end
