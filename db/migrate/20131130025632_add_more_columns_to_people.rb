class AddMoreColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :phone_number, :string
    add_column :people, :cal_net_dept_name, :string
    add_column :people, :hr_dept_name, :string  
    add_column :people, :job_title, :string  
  end
end
