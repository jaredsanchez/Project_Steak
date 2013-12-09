class AddAddressColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :room_number, :string
    add_column :people, :building, :string
  end
end
