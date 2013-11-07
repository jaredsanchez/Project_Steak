class MainController < ApplicationController
  def index
    @people = Person.all
    render 'index'
  end
end
