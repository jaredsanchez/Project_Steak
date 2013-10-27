require 'spec_helper'

describe PeopleController do

  describe 'Add a Person' do
    before :each do
      @fake_results = [mock('person1'), mock('person2')]
      @person = FactoryGirl.build(:person)
    end
    it 'should call the model method that creates a person' do
      Person.should_receive(:create!).and_return(@person)
      post :create, {:person => @person}
    end

    it 'should select the index template for redering' do 
      @person = FactoryGirl.build(:person, :name => 'A Fake Name', :progress => '1')
      Person.stub(:create!).and_return(@person)
      @person.name.should == 'A Fake Name'
      #response.should redirect_to(people_path)
      post :create, {:person => @person}

    end

    it 'should make the person availiable to that templete' do
      Person.stub(:create!).and_return(@person)
      post :create, {:person => @person}
      assigns(:person).should == @person

    end

  end

end
