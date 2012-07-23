class DropTrendsTable < ActiveRecord::Migration
  def up
    drop_table :trends
  end

  def down
  end
end
