class CreateEvents < ActiveRecord::Migration
  def up
  	create_table :events do |t|
      t.string :name
      t.text :description
      t.text :where
      t.datetime :when
      t.references :people
      # Add fields that let Rails automatically keep track
      # of when people are added or modified:
      t.timestamps
    end
  end

  def down
  	drop_table :events
  end
end
