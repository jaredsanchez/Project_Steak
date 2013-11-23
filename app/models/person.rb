class Person < ActiveRecord::Base
	has_and_belongs_to_many :events
	attr_accessible :name, :progress, :email, :is_linkedin_connection => false
end
