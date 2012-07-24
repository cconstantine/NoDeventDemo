class AddUserRemoveSubjectFromDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :username, :string
    remove_column :discussions, :subject
  end
end
