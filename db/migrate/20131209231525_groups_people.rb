class GroupsPeople < ActiveRecord::Migration
  def change
    create_table :groups_people do |t|
        t.belongs_to :group
        t.belongs_to :person
    end
  end
end
