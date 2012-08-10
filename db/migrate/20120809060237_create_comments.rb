class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :account_id
      t.text :message
      t.integer :discussion_id

      t.timestamps
    end
  end
end
