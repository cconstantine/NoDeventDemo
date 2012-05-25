class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.integer :count, :default => 0
      t.string :text

      t.timestamps
    end
    add_index :trends, :text
    add_index :trends, :count
  end
end
