class AddSlugToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :slug, :string
    add_index :discussions, :slug, unique: true
  end
end
