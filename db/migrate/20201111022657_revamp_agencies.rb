class RevampAgencies < ActiveRecord::Migration[6.0]
  def change
    change_table :agencies do |t|
      t.integer :lg_identifier, null: false
      t.string :abbreviation, null: false

      t.timestamps

      t.index :lg_identifier, unique: true
      t.index :abbreviation, unique: true
      t.index :name, unique: true
    end

    change_table :accounts do |t|
      t.references :agency, foreign_key: true
    end

    rename_column :accounts, :lg_account_id, :lg_identifier
    add_index :accounts, :lg_identifier, unique: true

    reversible do |dir|
      dir.up do
        remove_column :accounts, :lg_agency_id
      end

      dir.down do
        add_column :accounts, :lg_agency_id, :integer
      end
    end
  end
end
