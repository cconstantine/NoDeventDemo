class AddBonkToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :bonk_count, :integer, :default => 0
  end
end
