class Event < ActiveRecord::Base
	has_and_belongs_to_many :people
	attr_accessible :name,:description,:where,:when
end