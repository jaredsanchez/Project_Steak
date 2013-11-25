class AddActivePeopleColumn < ActiveRecord::Migration
  def up
    add_column :people, :active, :boolean, :default => false
  end

  def down
    remove_column :people, :active, :boolean, :default => nil
  end
end
