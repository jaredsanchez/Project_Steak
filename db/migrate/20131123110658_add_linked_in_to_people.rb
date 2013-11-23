class AddLinkedInToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_linkedin_connection, :boolean
  end
end
