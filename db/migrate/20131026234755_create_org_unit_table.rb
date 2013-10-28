class CreateOrgUnitTable < ActiveRecord::Migration
  def up
  	create_table :org_units do |t|
      t.string :org_node
      t.string :org_node_description
      t.integer :level
      t.timestamps
    end
  end

  def down
  	drop_table :org_units
  end
end

