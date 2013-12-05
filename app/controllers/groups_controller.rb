class GroupsController < ApplicationController
	def index
 	   @favorites = Person.find(:all, :conditions => { :favorite => true})
 	   @groups = Group.all
	end	
	def new
	end
	def create
		if ! params[:person].nil?
			person = Person.find_by_id params[:person][:person_id]
			group = Group.find_by_id params[:id]
			group.people << person
			group.save
			redirect_to groups_path
		else 
			@group = Group.new params[:group]
			@group.save
			redirect_to groups_path
		end
	end
end
