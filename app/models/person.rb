class Person < ActiveRecord::Base
	has_and_belongs_to_many :events
	attr_accessible :name, :first_name, :last_name, :progress, :favorite
end
