require 'factory_girl'

FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "jarlax#{n}" }
    sequence(:email) { |n| "jarlax#{n}@launchacademy.com" }
    sequence(:avatar_url) { |n| "https://avatars#{n}.githubusercontent.com/u/174825?v=3&s=400" }
  end
  factory :meetup do
    sequence(:name) { |n| "coolthing#{n}" }
    description "fun"
    location "somewhere"
    association :creator, factory: :user
  end
  factory :membership do
    meetup
    user
  end
  factory :comment do
    sequence(:body) { |n| "asdf#{n}" }
    user
    meetup
  end
end
