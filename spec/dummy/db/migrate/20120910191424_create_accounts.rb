class CreateAccounts < ActiveRecord::Migration[7.2]
  def up
    create_table :accounts, force: true do |t|
      t.string :business, null: false
      t.string :contact
      t.integer :age
      t.date :last_contact_on

      t.timestamps null: false
    end
  end

  def down
    drop_table :accounts
  end
end
