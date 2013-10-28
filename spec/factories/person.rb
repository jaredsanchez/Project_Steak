FactoryGirl.define do
  factory :person do
    name 'A Fake Name'
    progress '1'
    events [Event.create!(:name => 'Fake Event 1')]
  end
  #factory :event do
   # name 'A Fake Event'
   # description 'A Fake Presentation'
    #where 'Cory Hall'
    #when Time.now
  #end
end
