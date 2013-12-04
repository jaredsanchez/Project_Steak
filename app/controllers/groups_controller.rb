class GroupsController < ApplicationController
	def index
 	   @favorites = Person.find(:all, :conditions => { :favorite => true})
 	   @groups = Group.all
	end	
	def new
	end
	def create
		@group = Group.new params[:group]
		@group.save
		redirect_to groups_path
	end
end
