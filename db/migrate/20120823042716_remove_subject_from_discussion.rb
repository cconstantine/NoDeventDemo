class RemoveSubjectFromDiscussion < ActiveRecord::Migration
  def up
    remove_column :discussions, :subject
    remove_column :discussions, :slug
  end

  def down
    add_column :discussions, :slug, :string
    add_column :discussions, :subject, :string
  end
end
