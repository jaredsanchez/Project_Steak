# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    email "MyString"
    token "MyString"
    refresh_token "MyString"
    token_expires_at "2013-11-10 19:43:21"
  end
end
