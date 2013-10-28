class FixWhenCol < ActiveRecord::Migration
  def up
    rename_column :events, :when, :event_time
  end

  def down
  end
end
