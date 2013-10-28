class CreatePeople < ActiveRecord::Migration
  def up
  	create_table :people do |t|
      t.string :name
      # A number representing the progress of that person
      t.integer :progress
      t.references :events
      # Add fields that let Rails automatically keep track
      # of when people are added or modified:
      t.timestamps
    end
  end

  def down
  	drop_table :people
  end
end
