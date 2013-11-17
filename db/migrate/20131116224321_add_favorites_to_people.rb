class AddFavoritesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :favorite, :boolean
  end
end
