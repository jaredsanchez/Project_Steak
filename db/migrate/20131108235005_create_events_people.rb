class CreateEventsPeople < ActiveRecord::Migration
  def change

    create_table :events_people do |t|
      t.belongs_to :event
      t.belongs_to :person
    end
  end

end
