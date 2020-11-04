class RenameIAAsToIAAGTCs < ActiveRecord::Migration[6.0]
  def change
    # rename the table
    rename_table :iaas, :iaa_gtcs

    # fix up the table
    change_table :iaa_gtcs do |t|
      t.rename :number, :gtc_number
      t.integer :mod_number, null: false, default: 0
      t.index :gtc_number, unique: true
    end

    remove_column :iaa_gtcs, :active, :boolean, null: false, default: false
    remove_column :iaa_gtcs, :billed_amount, :integer
  end
end
