class RemoveUsernameAddUserToDiscussion < ActiveRecord::Migration
  def up
    remove_column :discussions, :username
    add_column :discussions, :user_id, :integer
  end

  def down
    remove_column :discussions, :user_id
  end
end
