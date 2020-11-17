class AddPartnerNameToStatuses < ActiveRecord::Migration[6.0]
  def change
    change_table :account_statuses do |t|
      t.string :partner_name
    end

    change_table :iaa_statuses do |t|
      t.string :partner_name
    end

    change_table :integration_statuses do |t|
      t.string :partner_name
    end
  end
end
